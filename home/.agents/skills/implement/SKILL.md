---
name: implement
description: "Implement work from a spec or tickets, from a focused change to a multi-ticket task graph."
disable-model-invocation: true
---

Implement the requested work and deliver it in the repository's normal workflow.

## Choose the workflow

- **Focused change or one ticket:** work on the current branch. Use `/tdd` where practical, at agreed seams; typecheck and run focused tests during implementation, then run the full suite once at the end.
- **Spec with multiple dependent tickets:** treat tickets as a task graph, not a checklist. Read the spec and tickets, identify the ready frontier, and work through it until the full spec is implemented. Use separate worktrees and implementer subagents for independent tickets when parallel work is available and useful. Keep shared context in links to the spec, tickets, and notes rather than repeating it in handoffs. Use an exploration subagent only when it would materially help multiple implementers.

For a multi-ticket spec, use one branch and draft PR when the repository's workflow supports them. Mark the PR as closing the spec and its tickets. Merge completed ticket work into that branch as blockers clear. After all tickets are done, run `/code-review` against the spec and repository standards, address findings, mark the PR ready, and clean up worktrees.

For either workflow, run `/code-review` when implementation is complete, fix any findings, and commit the finished work to the appropriate branch. If no PR workflow or required tool is available, complete the work on the current branch and report the limitation.
