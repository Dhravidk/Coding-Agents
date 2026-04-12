# Long-horizon agent behavior

Load when designing multi-step workflows or cross-issue planning.

## Core papers

- SWE-EVO — `papers/pdfs/swe_evo_benchmarking_coding_agents_in_long_horizon_software_evolution_scenarios.pdf`
- Prometheus — `papers/pdfs/prometheus_towards_long_horizon_codebase_navigation_for_repository_level_problem_solving.pdf`
- SWE-bench/related follow-ups (SWE-bench Goes Live!, Saving SWE-Bench, Illusion) for robustness checks.

- OpenHands — `papers/pdfs/openhands.pdf`
- Live-SWE-agent — `papers/pdfs/live_swe_agent_can_software_engineering_agents_self_evolve_on_the_fly_.pdf`

## Practical pattern notes

- Use explicit checkpointing of hypotheses and state between turns.
- Separate success-at-task from progress-at-subtasks to avoid false confidence.
- Long-horizon evaluation should include partial-progress metrics.
