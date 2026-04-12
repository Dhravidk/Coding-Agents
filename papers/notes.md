# Research Notes

Use this file as the shared coordination surface for multiple coding agents.

## Active claims

| Agent | Task | Scope | Start time | Expected finish |
| --- | --- | --- | --- | --- |
| _unassigned_ | _claim before editing_ | _file-level scope_ | _hh:mm_ | _hh:mm_ |

## Handoffs

- Add one handoff line whenever work changes direction or a run ends.
- Keep each handoff short and actionable (what changed + what is still missing).

## Evidence log

- Log only validated claims.
- Include source anchors when adding key findings (paper title + evidence status).
- If a paper is not verifiable via automation, mark as `MANUAL_REQUIRED`.

## Commit log (operational)

- Commit each meaningful change set before switching tasks.
- Include a one-line summary and list of files changed.
- Remove your active claim when you hand off or finish.

## Coordination defaults for this repo

- No silent edits: if you change a file that another agent may also edit, leave a claim in this section first.
- Keep `papers-manifest.csv` and `papers/paper_titles.txt` as append-only for a single batch where possible.
- Never overwrite another agent’s notes block without adding an addendum first.
