# DeepSeek through Codex CLI

Use this reference only for the `deepseek-codex` route. Use the locally configured `soclaas` profile; keep authentication in the user's existing environment. The profile currently resolves to provider `soclaas`, model alias `x-test-2`. Inspect the startup metadata each run rather than assuming the alias's underlying model is permanent.

## Start a worker

Prepare a unique task directory and a complete `brief.md`. Set `repo_dir` and `task_dir` to absolute paths for the current assignment. The brief should name `report.md` for the final report and `progress.md` for short milestone entries in that directory, in addition to the assigned files and acceptance criteria. These files let the orchestrator read findings without importing the event log.

```sh
mkdir -p "$task_dir"
codex exec --profile soclaas --cd "$repo_dir" --json \
  --output-last-message "$task_dir/final.txt" - \
  < "$task_dir/brief.md" \
  > "$task_dir/events.jsonl" 2> "$task_dir/diagnostics.log"
```

Use `--skip-git-repo-check` only when the task intentionally runs outside Git. Execute through the host's process tool so it can yield a session or handle for long work. Preserve the child's exit status, working directory, session identifier, report paths, and process handle; shell background launch success is not worker completion. Collect the exit status after it actually finishes.

Follow the parent task's execution permissions. Do not add approval bypasses or broaden filesystem access to get a worker running. If inherited profile permissions exceed the parent scope, narrow the invocation using supported local options or choose another authorized route.

## Capabilities and monitoring

The baseline for this setup is local shell execution and file access. Assign OpenAI plugins, ChatGPT artifact tools, built-in web search, and native subagents through another capable route. Treat additional capabilities as available only after verifying them in this specific harness.

The worker performs its assigned task directly unless its brief explicitly authorizes delegation. Reading a shared orchestration skill does not authorize recursive workers.

Monitor new entries in `progress.md`, the compact report, or selected JSON events. Relay meaningful milestones and blockers promptly. Keep diagnostics and full JSONL outside main-model context. A failed model request, tool error, or report mismatch needs investigation even if some files changed.

## Continue and collect

For related follow-up work, use the exact session identifier recorded by this worker; avoid `--last`, which can select another concurrent task. Check `codex exec resume --help` once per host/version before choosing resume options. Carry the same profile, working directory, and task permissions forward using options supported by that command. If profile selection is not supported on resume, use a fresh invocation with the compact prior findings rather than resuming under a different provider.

Confirm the process finished successfully, inspect the final report and selected provider/model, and validate the assigned artifacts against acceptance criteria. Report timeouts, interrupted sessions, and incomplete work explicitly. Start a new scoped worker or use the authorized fallback when recovery requires it.
