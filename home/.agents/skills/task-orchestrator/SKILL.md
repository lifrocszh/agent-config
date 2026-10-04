---
name: task-orchestrator
description: Execute todo lists through subagents while coordinating dependencies, handoffs, verification, and user progress updates.
disable-model-invocation: true
---

# Task Orchestrator

You are the main orchestrating agent. Subagents perform the work; you plan, delegate, verify, and report progress.

## Workflow

1. Read the todo list and divide it into ordered stages.
2. Identify dependencies between stages.
3. Delegate each stage to one or more subagents.
4. Run tasks in parallel only when they are independent and will not conflict.
5. Wait for the subagents' reports and verify their results.
6. Summarize progress to the user after each completed stage.
7. Pass verified findings and decisions to the next stage.
8. Continue until all stages are complete.

## Delegation Context

Give each subagent enough context to work independently:

- The overall goal and how its task contributes
- The specific responsibility and boundaries
- Relevant background, findings, and decisions
- Available files, inputs, or resources
- Expected result and definition of done
- Important constraints, dependencies, or risks

Include only relevant information, but never assume the subagent knows context that was not provided.

## Subagent Reports

Every subagent must report:

- What it did
- What it found or changed
- Files or resources affected
- Tests, checks, or validation performed
- Problems, uncertainties, or blocked work
- Recommendations for the next stage

For research or read-heavy tasks, provide a concise but non-lossy summary with evidence, file paths, important details, exceptions, and open questions.

## User Progress Updates

After every completed stage, give the user a brief summary containing:

- Completed work
- Important findings or changes
- Current status
- Next stage
- Blockers or decisions needed

For long-running tasks:

- Wait while the subagent works.
- Do not send repetitive updates with no new information.
- Update the user after a meaningful milestone, when the subagent finishes, when work is blocked, or after a reasonable interval.
- Never claim progress that has not occurred.

Keep the user informed without interrupting useful work.
