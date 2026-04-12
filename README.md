# Coding Agent Papers

## Goal

This repository is a structured research workspace for coding-agent literature (2025–2026 focus, with selective older work).  
The repository is organized so multiple coding agents can work in parallel without conflicts, while keeping paper evidence and artifacts reproducible.

## Agent-first structure

- `papers/`
  - `pdfs/` — archived PDFs downloaded for this repo.
  - `paper_titles.txt` — canonical list of targeted paper titles.
  - `papers-manifest.csv` — machine-readable status for every title (`found`, `failed`, `local_alias`, etc.).
  - `unresolved.txt` — title-level backlog for manual follow-up or non-arXiv sources.
  - `README.md` — operational guidance for paper-folder workflows.
  - `notes.md` — collective evidence notes and hypotheses.
- `scripts/`
  - `fetch_papers.sh` — idempotent fetch/update script for arXiv-first harvesting and manifest updates.

## How coding agents should work in this repo

1. Read the workflow files first:
   - `papers/papers-manifest.csv` to see current state.
   - `papers/unresolved.txt` for remaining manual targets.
   - `papers/notes.md` for current hypotheses and what has already been tried.
2. Choose one narrow task (for example: add 10 titles, clean up unresolved items, summarize new evidence).
3. Make changes only within your assigned scope.
4. Re-run:
   - `bash scripts/fetch_papers.sh`
5. Record what changed in `papers/notes.md` when you make evidence or interpretation updates.

## Multi-agent parallel work contract

To reduce merge conflicts and duplicate effort:

- Use branch-per-agent or branch-per-task and keep changes scoped.
- One agent = one slice:
  - ingestion
  - metadata cleanup
  - evidence note synthesis
  - script/automation improvements
- Do not edit the same file in the same semantic section at the same time.
- If touching the same file, each agent must coordinate section ownership (for example: one agent updates only line-level entries in `papers-manifest.csv`, another only `papers/notes.md`).
- Before taking a task, update your active claim in `papers/notes.md`.
- After completion, remove your claim and add a short handoff with open items.

## Frequent commit policy (required)

All work should be committed frequently:

- Minimum frequency: at least one commit every 30 minutes of active work, or sooner for any meaningful atomic change.
- Commit unit: one logical change only (e.g., “add titles + fetch PDFs” or “update notes for benchmark evidence”).
- Message format: include intent and scope in one line (e.g., `Ingest: add papers and refresh manifest`).
- Never mix evidence claims with file-format refactors in the same commit.
- Commit before context switch and before handing work to another agent.

## Quality rules for all edits

- Keep changes evidence-oriented and minimal.
- Prefer deterministic artifacts (CSV entries, file paths, command outputs) over prose-only claims.
- Avoid editing `papers/pdfs/*` manually; only the fetch script or explicit manual archival actions should modify PDFs.
- When uncertain about a paper source or metadata, keep it in `unresolved.txt` and annotate reason in notes.

## Repo-facing workflow for adding one paper

1. Add a title line to `papers/paper_titles.txt`.
2. Run `bash scripts/fetch_papers.sh`.
3. Confirm status in `papers/papers-manifest.csv`.
4. If `not_found_on_arxiv`, add the target venue/URL as a follow-up in `unresolved.txt`.
5. Document what was verified (or failed) in `papers/notes.md` if this is an evidence-bearing update.
