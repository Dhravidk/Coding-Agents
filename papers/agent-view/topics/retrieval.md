# Retrieval, navigation, and repo grounding

Load for file retrieval, code search, and local repo understanding.

## Core papers

- ContextBench — `papers/pdfs/contextbench_a_benchmark_for_context_retrieval_in_coding_agents.pdf`
- RepoReason (From Laboratory to Real-World Applications...) — `papers/pdfs/from_laboratory_to_real_world_applications_benchmarking_agentic_code_reasoning_at_the_repository_level.pdf`
- Prometheus — `papers/pdfs/prometheus_towards_long_horizon_codebase_navigation_for_repository_level_problem_solving.pdf`
- Repo2Run — `papers/pdfs/repo2run_automated_building_executable_environments_for_code_repository_at_scale.pdf`
- ReAct — `papers/pdfs/react.pdf`

## Practical pattern notes

- Retrieval success is only useful if the retrieved context is actually consumed.
- Prefer retrieval signals that include grounding quality, not only top-k hits.
