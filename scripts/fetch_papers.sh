#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
LIST_FILE="$ROOT_DIR/papers/paper_titles.txt"
PDF_DIR="$ROOT_DIR/papers/pdfs"
MANIFEST="$ROOT_DIR/papers/papers-manifest.csv"
UNRESOLVED="$ROOT_DIR/papers/unresolved.txt"
LOG="$ROOT_DIR/papers/fetch.log"

mkdir -p "$PDF_DIR"
: > "$MANIFEST"
: > "$LOG"
echo "title,status,source,notes,local_file" > "$MANIFEST"
: > "$UNRESOLVED"

declare -A MANUAL_ARXIV_IDS=(
  ["ABTest: Behavior-Driven Testing for AI Coding Agents"]="2604.03362"
  ["c-CRAB: Code Review Agent Benchmark"]="2603.23448"
  ["From Laboratory to Real-World Applications: Benchmarking Agentic Code Reasoning at the Repository Level"]="2601.03731"
  ["SWE-Bench-CL: Continual Learning for Coding Agents"]="2507.00014"
  ["EXPEREPAIR: Dual-Memory Enhanced LLM-based Repository-Level Program Repair"]="2506.10484"
  ["SWE-Spot: Building Small Repo-Experts with Repository-Centric Learning"]="2601.21649"
  ["SWE-PolyBench"]="2504.08703"
  ["FEA-Bench"]="2503.06680"
  ["More with Less: An Empirical Study of Turn-Control Strategies for Efficient Coding Agents"]="2510.16786"
  ["SWE-Effi: Re-Evaluating Software AI Agent System Effectiveness Under Resource Constraints"]="2509.09853"
  ["Dissecting the SWE-Bench Leaderboards"]="2506.17208"
  ["Otter: Generating Tests from Issues to Validate SWE Patches"]="2502.05368"
  ["Heterogeneous Prompting and Execution Feedback for SWE Issue Test Generation and Selection"]="2508.06365v2"
  ["Agentic Harness for Real-World Compilers"]="2603.20075"
  ["ReAct"]="2210.03629"
  ["OpenHands"]="2407.16741"
  ["SEAlign: Alignment Training for Software Engineering Agents"]="2503.18455"
  ["ToolTrain: Enhancing Issue Localization Agent with Tool-Interactive Training"]="2508.03012"
  ["RepoReason: Benchmarking Agentic Code Reasoning at the Repository Level"]="2601.03731"
)

normalize_slug() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '_'
}

encode_query() {
  printf '%s' "$1" \
    | sed -E 's/[^A-Za-z0-9 ]+/ /g' \
    | tr -s '[:space:]' '+' \
    | sed -E 's/^\+//; s/\+$//'
}

lookup_arxiv() {
  local title="$1"
  local mode="$2"
  local query
  query="${mode}:$(encode_query "$title")"
  curl -sS "https://export.arxiv.org/api/query?search_query=${query}&start=0&max_results=5"
}

fetch_pdf() {
  local title="$1"
  local source="$2"
  local xml="$3"

  local arxiv_id id_path pdf_url slug local_file
  arxiv_id=$(printf '%s' "$xml" | grep -oE 'http://arxiv\.org/abs/[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?' | head -n 1 || true)

  if [ -z "$arxiv_id" ]; then
    return 1
  fi

  id_path=${arxiv_id##*/}
  pdf_url="https://arxiv.org/pdf/${id_path}.pdf"
  slug=$(normalize_slug "$title")
  local_file="$PDF_DIR/${slug}.pdf"

  if curl -fL --max-time 90 "$pdf_url" -o "$local_file" >/dev/null 2>>"$LOG"; then
    if [ -s "$local_file" ]; then
      echo "${title},found,$source,arxiv:${id_path},$local_file" >> "$MANIFEST"
      echo "FOUND\t${title}" >> "$LOG"
      return 0
    fi
  fi

  rm -f "$local_file"
  echo "${title},failed,$source,pdf_download_failed,$local_file" >> "$MANIFEST"
  echo "FAILED\t${title}" >> "$LOG"
  return 1
}

fetch_pdf_by_arxiv_id() {
  local title="$1"
  local arxiv_id="$2"
  local slug local_file pdf_url

  slug=$(normalize_slug "$title")
  local_file="$PDF_DIR/${slug}.pdf"
  pdf_url="https://arxiv.org/pdf/${arxiv_id}.pdf"

  if curl -fL --max-time 90 "$pdf_url" -o "$local_file" >/dev/null 2>>"$LOG"; then
    if [ -s "$local_file" ]; then
      echo "${title},found,manual_arxiv,${arxiv_id},${local_file}" >> "$MANIFEST"
      echo "FOUND\t${title}" >> "$LOG"
      return 0
    fi
  fi

  rm -f "$local_file"
  echo "${title},failed,manual_arxiv,pdf_download_failed,${local_file}" >> "$MANIFEST"
  echo "FAILED\t${title}" >> "$LOG"
  return 1
}

while IFS= read -r title; do
  [ -z "${title//[[:space:]]/}" ] && continue
  case "$title" in
    \#*) continue;;
  esac

  slug=$(normalize_slug "$title")
  local_file="$PDF_DIR/${slug}.pdf"

  if [ -s "$local_file" ]; then
    echo "${title},found,local,already_present,$local_file" >> "$MANIFEST"
    continue
  fi

  if [[ -n "${MANUAL_ARXIV_IDS[$title]:-}" ]]; then
    if fetch_pdf_by_arxiv_id "$title" "${MANUAL_ARXIV_IDS[$title]}"; then
      continue
    fi
  fi

  if [ "$title" = "SWE-bench" ]; then
    # Alias for the original SWE-bench benchmark title already in the list.
    alias_title="SWE-bench: Can Language Models Resolve Real-World GitHub Issues?"
    alias_file="$PDF_DIR/$(normalize_slug "$alias_title").pdf"
    if [ -s "$alias_file" ]; then
      echo "${title},found,local_alias,duplicate_title_entry,$alias_file" >> "$MANIFEST"
    else
      echo "${title},failed,local_alias,duplicate_title_missing,$alias_file" >> "$MANIFEST"
    fi
    continue
  fi

  xml=$(lookup_arxiv "$title" "ti")
  total=$(printf '%s' "$xml" | grep -oE '<opensearch:totalResults>[0-9]+' | head -n 1 | cut -d'>' -f2 || true)

  if [ -n "${total:-}" ] && [ "$total" -gt 0 ]; then
    if fetch_pdf "$title" "arxiv-ti" "$xml"; then
      continue
    fi
  fi

  xml=$(lookup_arxiv "$title" "all")
  total=$(printf '%s' "$xml" | grep -oE '<opensearch:totalResults>[0-9]+' | head -n 1 | cut -d'>' -f2 || true)

  if [ -n "${total:-}" ] && [ "$total" -gt 0 ]; then
    if fetch_pdf "$title" "arxiv-all" "$xml"; then
      continue
    fi
  fi

  echo "${title},not_found,none,not_found_on_arxiv," >> "$MANIFEST"
  echo "UNRESOLVED\t${title}" >> "$UNRESOLVED"
 done < "$LIST_FILE"

echo "Done.\nManifest: $MANIFEST\nUnresolved: $UNRESOLVED\nPDF directory: $PDF_DIR" 
echo "Refreshing compact catalog: $ROOT_DIR/papers/catalog.jsonl"
bash "$ROOT_DIR/scripts/build_agent_index.sh"
