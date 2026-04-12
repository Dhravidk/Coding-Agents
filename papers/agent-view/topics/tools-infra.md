# Tools, infrastructure, and repo execution

Load for environment setup, build/test reliability, and tool-calling patterns.

## Core papers

- Repo2Run — `papers/pdfs/repo2run_automated_building_executable_environments_for_code_repository_at_scale.pdf`
- Agentic Harness for Real-World Compilers — `papers/pdfs/agentic_harness_for_real_world_compilers.pdf`
- OpenHands — `papers/pdfs/openhands.pdf`
- ToolTrain — `papers/pdfs/tooltrain_enhancing_issue_localization_agent_with_tool_interactive_training.pdf`
- Heterogeneous Prompting and Execution Feedback... — `papers/pdfs/heterogeneous_prompting_and_execution_feedback_for_swe_issue_test_generation_and_selection.pdf`

## Practical pattern notes

- Make environment bootstrap deterministic before optimizing model loops.
- Treat tool failures as first-class events with separate counters/logs.
- Keep resource budgets explicit: time, tests, file writes, and token caps.
