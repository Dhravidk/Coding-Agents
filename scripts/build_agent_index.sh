#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "$0")/.." && pwd)
TITLE_FILE="$ROOT_DIR/papers/paper_titles.txt"
MANIFEST="$ROOT_DIR/papers/papers-manifest.csv"
THEME_MAP="$ROOT_DIR/papers/theme-overrides.tsv"
OUT="$ROOT_DIR/papers/catalog.jsonl"

json_escape() {
  printf '%s' "$1" \
    | sed 's/\\/\\\\/g; s/\"/\\\"/g; s/\r/\\r/g; s/\n/\\n/g'
}

find_manifest_line() {
  local title="$1"
  local line

  while IFS= read -r line; do
    if [[ "${line:0:${#title}}" == "$title" && "${line:${#title}:1}" == "," ]]; then
      echo "$line"
      return 0
    fi
  done < "$MANIFEST"

  return 1
}

find_themes() {
  local title="$1"
  local map_title map_themes

  while IFS=$'\t' read -r map_title map_themes map_note; do
    if [[ -z "$map_title" || "$map_title" == "#title" ]]; then
      continue
    fi
    if [[ "$map_title" == "$title" ]]; then
      if [[ -z "$map_themes" ]]; then
        echo "unclassified"
      else
        echo "$map_themes"
      fi
      return 0
    fi
  done < "$THEME_MAP"

  echo "unclassified"
}

: > "$OUT"

while IFS= read -r title; do
  [[ -z "${title//[[:space:]]/}" ]] && continue

  if [[ "$title" == \#* ]]; then
    continue
  fi

  manifest_line=""
  if ! manifest_line=$(find_manifest_line "$title"); then
    continue
  fi

  rest=${manifest_line#${title},}
  IFS=',' read -r status source notes local_file <<< "$rest"

  themes_csv=$(find_themes "$title")
  themes="unclassified"
  if [[ "$themes_csv" != "unclassified" ]]; then
    themes="$themes_csv"
  fi

  rel_file=""
  if [[ -n "$local_file" ]]; then
    rel_file=${local_file#$ROOT_DIR/}
  fi

  source_id=""
  if [[ "$notes" =~ (arxiv:[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?) ]]; then
    source_id=${BASH_REMATCH[1]#arxiv:}
  elif [[ "$notes" =~ ^[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?$ ]]; then
    source_id="$notes"
  elif [[ "$status" == "local_alias" ]]; then
    source_id="swe-bench-arxiv"
  fi

  year=""
  if [[ -n "$source_id" && "$source_id" =~ ^([0-9]{2})([0-9]{2})\.[0-9]{4,5} ]]; then
    year="20${BASH_REMATCH[1]}${BASH_REMATCH[2]}"
  elif [[ -n "$source_id" && "$source_id" =~ ^([0-9]{4}) ]]; then
    year="${BASH_REMATCH[1]}"
  fi

  ready="false"
  if [[ "$status" == "found" || "$status" == "local" || "$status" == "local_alias" ]]; then
    ready="true"
  fi

  themes_json="["
  if [[ "$themes" != "unclassified" ]]; then
    IFS='|' read -r -a theme_parts <<< "$themes"
    sep=""
    for t in "${theme_parts[@]}"; do
      if [[ -z "$t" ]]; then
        continue
      fi
      themes_json+="${sep}\"$(json_escape "$t")\""
      sep=",";
    done
  fi
  themes_json+="]"

  if [[ -z "$year" ]]; then
    year_value="null"
  else
    year_value="$year"
  fi

  title_j=$(json_escape "$title")
  source_j=$(json_escape "$source")
  notes_j=$(json_escape "$notes")
  rel_file_j=$(json_escape "$rel_file")
  source_id_j=$(json_escape "$source_id")

  echo "{\"title\":\"$title_j\",\"status\":\"$status\",\"source\":\"$source_j\",\"source_id\":\"$source_id_j\",\"year\":$year_value,\"themes\":$themes_json,\"ready\":$ready,\"local_file\":\"$rel_file_j\",\"notes\":\"$notes_j\"}" >> "$OUT"
done < "$TITLE_FILE"

echo "Wrote $OUT"
