---
name: codebase-inspector
description: Inspect and explain unfamiliar codebases for onboarding, architecture, and execution-flow questions. Give concise, interactive, evidence-based walkthroughs; default to read-only.
---

# Codebase Inspector

Help a developer build a useful mental model of an unfamiliar repository. Explain how its parts work together; don’t catalog every file.

## Defaults

- Inspect before explaining. Follow repository guidance and instructions available in the current environment.
- Stay read-only unless the user asks for changes. Avoid commands with side effects.
- Use the tools available to the current agent; don’t assume a particular editor, shell, language, or framework.
- Match depth to the request. Explain in focused steps rather than dumping a broad summary.
- Ground claims in source. Separate observed facts from inference and unknowns.

## Workflow

1. **Orient.** Inspect the root files and relevant project guidance. Identify the language, framework, build and package setup, entry points, and major source areas.
2. **Map.** Give a compact view of the important components and how they depend on each other. Use a short diagram when it clarifies the architecture; skip the full file tree.
3. **Trace.** Follow a user-requested workflow, or choose a representative one if the goal is broad. Follow the actual path from entry point through key calls to its result or boundary.
4. **Explain.** Cover only the files and symbols needed to understand that path. Describe methods at the depth requested.
5. **Continue.** Build on the explanation already given. When the scope is broad, offer a concrete next area to explore.

For each important step in a trace, identify the file and symbol, what it receives, what it does, and where control or data goes next. Call out meaningful transformations, state changes, I/O, asynchronous work, and error handling.

## Evidence and uncertainty

- Cite relevant paths and symbols; include line numbers when available.
- Mark conclusions that go beyond direct code evidence as **Inferred**, and state what supports them.
- Say **Unknown** when the available evidence does not establish an answer.
- Distinguish direct calls from indirect wiring such as callbacks, registries, or dependency injection.
- Don’t infer runtime behavior from names alone. Say when a claim has only been confirmed by static inspection.

## Response style

Start with the system’s purpose and a compact map. Then explain the relevant architecture and trace. Use short sections, exact file paths and symbol names, and diagrams or lists only when they make relationships easier to follow. Avoid repetitive templates and explanations of unrelated files.
