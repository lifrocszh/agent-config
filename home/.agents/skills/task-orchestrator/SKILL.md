---
name: task-orchestrator
description: Plan and execute goals or todo lists through inexpensive workers, with capability-aware routing, compact handoffs, verification, and active progress updates.
disable-model-invocation: true
---

# Task Orchestrator

Keep the current main model as the planner and orchestrator. Delegate discovery, implementation, and verification to capable inexpensive workers. Conserve main-model context and usage across the completed task while preserving the quality bar. Handle trivial coordination directly when delegation would cost more.

## Worker selection

Honor choices such as `Workers: luna. Effort: max.`, `Workers: deepseek-codex.`, `Workers: deepseek-pi.`, or `Workers: deepseek-pi. Fallback: luna.` Keep the choice active for this run until the user changes it. Otherwise choose `auto` and announce the initial route without a configuration questionnaire.

| Route | Use |
| --- | --- |
| `deepseek-codex` | Bounded local discovery, implementation, and checks using the `soclaas` Codex profile. Read [Codex CLI](references/codex-cli.md) when selecting this route. |
| `deepseek-pi` | Work needing Pi web search or explicitly scoped nested delegation, as well as local tasks. Read [Pi](references/pi.md) when selecting this route. |
| `luna` | Native `gpt-6-luna` workers for OpenAI harness capabilities or stronger execution. Default reasoning: `xhigh`; use `max` when requested or needed for escalation. |
| `auto` | Select the cheapest capable available route for each task. Prefer DeepSeek for suitable work; use Luna when capabilities or observed quality require it. |

Use the available native delegation tool for Luna. With `collaboration.spawn_agent`, set `model: "gpt-6-luna"`, `reasoning_effort: "xhigh"` (or `"max"`), and `fork_turns: "none"`. Give a complete brief rather than copying the main conversation. If that model, effort, or delegation tool is unavailable, surface the limitation and use only an authorized alternative. Automatic routing never lowers Luna below `xhigh`.

Check actual tool access before assigning plugins, spreadsheets, search, or subagents; worker capabilities differ by harness. Use an authorized capable worker or the main agent for a required tool call. Worker pins govern delegated workers; main-agent tool calls use the task's existing authorization. The skill selects workers; it does not switch the main chat's model.

In `auto`, announce route changes and quality escalation as they happen. For a pinned route, use only its stated fallback; obtain the user's choice before switching to another route. A stated fallback authorizes switching when a required capability is unavailable, launch or execution fails, or verification still fails after a focused repair; honor any narrower conditions the user specifies. Keep capability-dependent work pending while continuing independent work. No silent provider or model substitution.

## Plan and delegate

1. Accept a goal or existing todo list. Establish the target and intended change from available context, then build a compact plan with dependencies and checkable acceptance criteria. Delegate bounded reconnaissance for discoverable facts; ask only for missing decisions or information unavailable from accessible sources.
2. Keep a small record of task, stage, worker, state, and evidence locations. Reuse the host's planning tool or a task-local file; keep detailed findings outside main context.
3. Delegate coherent units of work. Parallelize independent tasks with separate file ownership; sequence overlapping writes. Preserve existing changes and account for concurrent workers when reviewing diffs.
4. Pass verified findings and decisions to dependent workers. Reuse a worker for related follow-up work when its context remains relevant; start fresh for unrelated work or independent verification.
5. Continue through implementation, checks, and acceptance until the goal is complete or a concrete blocker requires user input.

Give every worker a self-contained brief containing:

- Overall goal, assigned responsibility, and definition of done.
- Working directory, owned files or resources, relevant inputs, findings, and decisions.
- Constraints, dependencies, available capabilities, and required validation.
- Expected report and locations for detailed evidence or artifacts.
- Delegation permission. Default: perform the task directly. If children are useful, explicitly assign their scope, allowed route, maximum count, and depth; children do not delegate further unless authorized.

Provide relevant context fully; never assume a fresh worker knows this conversation. Workers inherit the task's permissions, not broader authority to publish, send messages, or change unrelated configuration.

## Reports and acceptance

Ask for a compact report covering outcome, findings or changes, affected resources, checks and results, evidence paths, unresolved issues, and the next dependency. Research reports preserve decisive facts, exceptions, and source locations. Keep raw logs and extensive excerpts in files.

Use another worker for verification when complexity or risk warrants it. Give that verifier the requirements, relevant artifacts, and checks to perform so it can assess the result independently. Require evidence for each acceptance criterion and validation appropriate to the task; a successful process exit or worker assertion alone is insufficient. For live artifact changes, compare readback against the intended result.

The main agent reviews compact evidence, resolves disagreements, and owns final acceptance. Inspect targeted source or run a decisive check when reports conflict or leave a material gap. After a focused repair fails or a capability mismatch appears, improve the brief or escalate through an authorized route instead of repeating the same unsuccessful assignment. Reserve expensive reasoning for decisions that need it.

## Active progress updates

Give an initial update naming the current stage and chosen workers. Then update promptly whenever meaningful progress occurs, including within a stage: enough evidence gathered, a decision made, a coherent implementation completed, verification started or finished, a defect discovered, a blocker, or a changed plan or route. Each update briefly states the stage, concrete progress, and next action or required decision.

Ask workers to surface milestones and blockers as they occur. Use native notifications or external worker progress files and event streams; inspect only new compact information while monitoring jobs. Use bounded waits that keep the main agent responsive. Relay meaningful updates before dispatching the next stage; do not save all updates for the final response or wait for every parallel worker when one result unlocks progress.

Updates follow progress rather than a five-minute schedule. Avoid unchanged status messages, raw logs, token-by-token narration, and counting spawns as completed work. A milestone update can be as short as: "Discovery complete: found the cause. Assigning Luna xhigh to implement the fix."

Finish with completed outcomes, validation evidence, and any unresolved work or limitations.
