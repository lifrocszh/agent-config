# DeepSeek through Pi

Use this reference only for the `deepseek-pi` route. This setup registers provider `soclaas`, model alias `x-test-2` (DeepSeek V4.1 Flash 1017). Pin that provider/model for this route so a changed interactive default cannot silently select another model. If unavailable, inspect the local model catalog and report the mismatch instead of guessing a replacement. Keep credentials in the user's existing environment.

## Start a worker

Prepare a unique task directory and a complete `brief.md`. Set `repo_dir` and `task_dir` to absolute paths. Require the worker to write a compact final `report.md` and append meaningful milestones or blockers to `progress.md` in that directory. Keep extension discovery enabled for search and subagent access.

```sh
mkdir -p "$task_dir"
cd "$repo_dir"
pi --provider soclaas --model x-test-2 --print --mode json \
  --session-dir "$task_dir/sessions" \
  < "$task_dir/brief.md" \
  > "$task_dir/events.jsonl" 2> "$task_dir/diagnostics.log"
```

Use the host's process tool to retain a handle and yield while long work continues. Record the working directory, session ID/path, report paths, and actual exit status. Preserve parent permissions and project trust; do not add trust flags or enable broader capabilities to bypass a restriction.

JSON mode emits a session header followed by events. Completed assistant messages are `message_end` events with `message.role == "assistant"`; read their text blocks or use `report.md`. `agent_end` can precede automatic retry or recovery; `agent_settled` indicates no further automatic work, and `aborted: true` means interruption. Check final assistant errors, process status, and artifacts as well as settlement. Full logs stay outside main-model context.

## Search and nested workers

Installed packages in this setup include `pi-web-access` and `@everyx/pi-subagent`. Check actual loaded tools before assigning them; installed packages alone do not prove that a search provider is working. Search tools include `web_search` and `fetch_content`. Return source URLs and the evidence used. Treat extension errors as a capability failure and use an authorized fallback when necessary.

The subagent extension exposes `agent_spawn`, `agent_send`, and `agent_stop`. It inherits the current model and thinking level unless explicitly overridden. Keep children on the permitted route; give any Luna child `xhigh` or an explicitly selected `max` if that model is actually registered. Each child receives its own complete brief and file ownership.

**Headless lifecycle constraint:** `pi --print` shuts down its children when the host exits. Use foreground `agent_spawn` (`run_in_background: false`, `persistent: false`) for nested workers so the tool waits for their settled results. For parallel work, prefer several outer Pi workers managed by the main orchestrator. Background notification workflows require a deliberately managed long-lived RPC host; the one-shot command above does not provide one.

The extension imposes no nesting depth cap. Pass explicit child-count and depth limits in the brief; enforce visibility with a tool allowlist when practical. Default workers perform the task directly. A nested worker's result must be collected before the Pi parent finishes its report.

## Monitor and continue

Read new progress entries or selected completed-message events while the process runs. Relay substantive milestones as they arrive. For related follow-up work, use `pi --session <exact-session-path-or-id>` with the same provider/model, output options, and working directory. Avoid `--continue`, which may attach to another concurrent worker's session. Use local `pi --help` and installed extension documentation when command behavior differs by host/version.

Confirm task completion from the actual report, required checks, and affected artifacts. Treat interrupted children, missing results, provider errors, and incomplete reports as unresolved work even when the parent printed a final response.
