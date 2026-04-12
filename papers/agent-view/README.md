# Agent navigation map

This folder is intentionally small so agents can load only what they need.

## Directory tree (repo-relative)

```text
papers/
  catalog.jsonl
  theme-overrides.tsv
  agent-view/
    README.md
    graph/
      README.md
      knowledge-graph.mmd
    topics/
      harness.md
      memory-compaction.md
      retrieval.md
      verification-selection.md
      long-horizon.md
      evaluation-benchmarks.md
      tools-infra.md
  papers-manifest.csv
  paper_titles.txt
  unresolved.txt
  notes.md
  README.md (legacy notes and coordination)
  pdfs/
```

## Loading rule

Agents should only open one topic file from `topics/` at a time.

Recommended:

1. Open `catalog.jsonl` for paper-level metadata.
2. Open one topic file for the active question.
3. If a file is missing a key paper for your task, add a tiny update to
   `theme-overrides.tsv` and rebuild with:

   `bash scripts/build_agent_index.sh`

## Scope boundaries

- `catalog.jsonl` must stay machine-lean and under 2KB per agent read session.
- Topic files should stay short and actionable.
- `notes.md` is for agent handoffs and is not a place for full essays.
