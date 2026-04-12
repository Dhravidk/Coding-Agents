# Coding Agent Papers

This repository is a long-horizon research workspace for coding-agent literature (2025-2026 focus), with papers stored under `papers/`.

## Structure

- `papers/`
  - `pdfs/` — downloaded paper PDFs.
  - `papers-manifest.csv` — machine-readable status of attempted downloads.
  - `paper_titles.txt` — source list used for paper collection.
  - `README.md` — paper collection guide.
  - `notes.md` — place for local notes and interpretation.
- `scripts/`
  - `fetch_papers.sh` — scripted best-effort arXiv lookup and PDF downloader.

## Getting started

1. Add or update titles in `papers/paper_titles.txt`.
2. Run:
   - `bash scripts/fetch_papers.sh`
3. The script writes outputs to:
   - `papers/papers-manifest.csv`
   - `papers/unresolved.txt`
   - `papers/pdfs/<slug>.pdf` for successful downloads.

## Notes

- This repo intentionally tracks a narrow, evidence-oriented set of papers for coding-agent research.
- The downloader is best-effort: if a paper is not on arXiv, it is left in `unresolved.txt` for manual follow-up (conference/proceedings/OpenReview pages, etc.).
