# Papers folder operating notes

This folder is the source of truth for paper ingestion and retrieval status.
Everything here is designed for coding agents to work on in parallel with minimal conflict.

## Files and their roles

- `paper_titles.txt`
  - One paper title per line, one paper per line.
  - Primary input for ingestion runs.
- `papers-manifest.csv`
 - `title`: canonical title string.
 - `status`: `found`, `not_found`, `local`, `local_alias`, `failed`.
 - `source`: where the entry came from (`arxiv`, `manual_arxiv`, `local_alias`, `local`).
 - `notes`: fetch ID, reason, or failure signal.
 - `local_file`: path to PDF when found.
- `unresolved.txt`
  - Explicit backlog queue.
  - Must stay non-empty only when title is genuinely blocked by source limitations.
- `pdfs/`
  - Deterministic filename slugs.
  - Additions should come from script-driven ingestion or explicit manual archival with a note in `notes.md`.
- `notes.md`
  - Shared state for evidence quality, assumptions, open gaps, and handoffs.
- `fetch.log` (generated)
  - Per-run trace for debugging fetch behavior.

## Parallel agent protocol in this folder

1. Before editing, claim your file scope in `notes.md` (agent name + task + expected completion window).
2. Prefer appending to files over rewriting whole files.
3. Don’t remove another agent’s active claim block.
4. If a file is needed by multiple agents, coordinate section ownership.
5. Keep `paper_titles.txt` additions sorted by decision order or thematic group; avoid duplicate title strings.

## Standard run procedure

1. Add/adjust target titles in `paper_titles.txt`.
2. Run:
   - `bash scripts/fetch_papers.sh`
3. Confirm that each new title has an entry in `papers-manifest.csv`.
4. Move unresolved cases to a clear follow-up plan in `notes.md`.
5. Record one summary line in `notes.md` before ending session.

## Source policy

- Priority: arXiv + verified primary sources.
- If arXiv misses the title but a known primary source exists, do not guess a PDF.
- Add explicit venue/source notes in `notes.md` and keep unresolved queue explicit.

## Commit discipline inside this folder

- If you touch `paper_titles.txt`, `papers-manifest.csv`, `unresolved.txt`, or `notes.md`, commit that change within one logical session.
- Keep one commit per independent ingestion batch (smallest useful atomic unit).
