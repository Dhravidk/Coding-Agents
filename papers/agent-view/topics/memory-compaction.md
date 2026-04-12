# Memory, long-context, and compaction

Load for memory design, context budget, or long-horizon continuity work.

## Core papers

- Prometheus — `papers/pdfs/prometheus_towards_long_horizon_codebase_navigation_for_repository_level_problem_solving.pdf`
  - repository graph + working-memory structure.
- ContextBench — `papers/pdfs/contextbench_a_benchmark_for_context_retrieval_in_coding_agents.pdf`
  - context retrieval quality + usage gap measurements.
- ACON: Optimizing Context Compression for Long-horizon LLM Agents — `papers/pdfs/acon_optimizing_context_compression_for_long_horizon_llm_agents.pdf`
  - compression optimization methodology.
- CoMem — `papers/pdfs/comem_context_management_with_a_decoupled_long_term_memory.pdf`
  - memory offload architecture.
- EXPEREPAIR — `papers/pdfs/experepair_dual_memory_enhanced_llm_based_repository_level_program_repair.pdf`
  - episodic + semantic memory setup for repair tasks.

## Practical pattern notes

- Build compact memory layers first for retrieval precision, then add generative context.
- Keep compaction signals explicit (what was dropped and why).
- Distinguish short-term planning context from durable task memory.
