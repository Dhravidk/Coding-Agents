# Agent harness and orchestration

Load only when working on scaffolds, controller loops, tool orchestration, or repo interaction.

## Core papers

- SWE-agent — `papers/pdfs/swe_agent_agent_computer_interfaces_enable_automated_software_engineering.pdf`
  - baseline agent-computer interface and loop design.
- SWE-bench: Can Language Models Resolve Real-World GitHub Issues? — `papers/pdfs/swe_bench_can_language_models_resolve_real_world_github_issues_.pdf`
  - benchmark framing for issue fixing context.
- Demystifying LLM-Based Software Engineering Agents — `papers/pdfs/demystifying_llm_based_software_engineering_agents.pdf`
  - workflow decomposition for harness behavior.
- Co-PatcheR — `papers/pdfs/co_patcher_collaborative_software_patching_with_component_s_specific_small_reasoning_models.pdf`
  - multi-component harness behavior.
- Agentic Harness for Real-World Compilers — `papers/pdfs/agentic_harness_for_real_world_compilers.pdf`
  - specialized harness pattern for hard domains.

## Practical pattern notes

- Prioritize deterministic tool calls + verifiable state transitions.
- Keep the controller split from verifier and retrieval to reduce debugging complexity.
- For coding-agent experiments, track turn policy and retry semantics explicitly.

