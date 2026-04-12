# Papers folder map and fast paths

This folder is an evidence-first workspace for coding-agent literature ingestion and navigation.

## Core files

- `paper_titles.txt`: canonical paper list used by the fetch pipeline.
- `papers-manifest.csv`: status dump from ingestion (`found`, `local`, `local_alias`, `failed`, etc.).
- `unresolved.txt`: backlog for manual follow-up.
- `notes.md`: coordination + operational notes.
- `fetch.log`: last run trace from `scripts/fetch_papers.sh`.
- `theme-overrides.tsv`: authoritative theme mapping for each title.
- `catalog.jsonl`: compact, machine-friendly paper index built for agent workflows.
- `agent-view/`: minimal-context directory system for parallel agents.

## Recommended file loading order (short context)

Before starting any coding-agent task:

1. `agent-view/README.md` (navigation + scope)
2. `catalog.jsonl` (full metadata, one line per paper)
3. One topic file in `agent-view/topics/`

If you need raw fetch status, open `papers-manifest.csv` only.

## Navigation contract for multiple agents

1. Do not edit the same topic file at the same time.
2. One agent task = one topic file.
3. Add evidence or interpretations only to `notes.md` in a short scoped block.
4. For any metadata changes, record the change in `notes.md` before commit.

## Data layout inside `agent-view/`

- `agent-view/README.md`  - directory map and read rules.
- `agent-view/graph/`     - Mermaid graph of relationships between themes.
- `agent-view/topics/`    - focused topic briefs.
- `agent-view/` is intentionally light to reduce context pressure for agents.

## Manual topic edits

When adding a new paper:

1. Add title to `paper_titles.txt`.
2. Run:
   - `bash scripts/fetch_papers.sh`
   - `bash scripts/build_agent_index.sh`
3. Add/adjust its theme entry in `theme-overrides.tsv`.
4. Commit with a short scoped message.

