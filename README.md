# Coding-Agent Research Library

A structured literature workspace for coding-agent research, focused on 2025–2026 with selected earlier work. It keeps source PDFs, retrieval status, thematic indexes, and evidence notes together so a research question can be traced back to its sources.

[Paper catalog](papers/catalog.jsonl) · [Topic index](papers/agent-view/README.md) · [Evidence notes](papers/notes.md) · [Unresolved sources](papers/unresolved.txt)

## Start with a research question

1. Read the [topic map](papers/agent-view/README.md).
2. Select the relevant topic and inspect its entries in `papers/catalog.jsonl`.
3. Read the original paper before adding a claim to `papers/notes.md`.
4. Use `papers/papers-manifest.csv` when you need retrieval status or source provenance.

This public repository is a literature and evidence workspace. A paper's presence in the catalog does not mean its results have been reproduced, and this checkout does not contain the newer local benchmark implementation suites.

## Repository map

| Location | Purpose |
| --- | --- |
| `papers/pdfs/` | Archived source PDFs |
| `papers/paper_titles.txt` | Targeted paper titles |
| `papers/papers-manifest.csv` | Machine-readable retrieval status |
| `papers/catalog.jsonl` | Compact paper catalog |
| `papers/theme-overrides.tsv` | Curated topic assignments |
| `papers/agent-view/` | Topic-based navigation |
| `papers/notes.md` | Evidence notes and hypotheses |
| `papers/unresolved.txt` | Sources needing manual follow-up |
| `scripts/fetch_papers.sh` | ArXiv-first source retrieval and manifest updates |
| `scripts/build_agent_index.sh` | Catalog and navigation generation |

## Add or refresh sources

```bash
# Add the target title to papers/paper_titles.txt, then:
bash scripts/fetch_papers.sh
bash scripts/build_agent_index.sh
```

Inspect the manifest and unresolved-source list after retrieval. Record the source, what was verified, and the limits of the interpretation in the evidence notes. See [paper-folder guidance](papers/README.md) before changing the archive.

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

## Fast path for multiple agents

Use this read order before editing:

1. `papers/agent-view/README.md` (tree + navigation)
2. `papers/catalog.jsonl` (compact metadata)
3. Exactly one file in `papers/agent-view/topics/`

Avoid loading `papers/papers-manifest.csv` unless needed for raw ingestion debugging.
