## User preferences

- Keep responses concise and straight to the point.
- Use preferred modern CLIs by default when available:
  - `fd` instead of `find`
  - `rg` instead of `grep`
  - `eza` instead of `ls`
  - `bat` instead of `cat` for shell display
  - `read` tool instead of `cat`/`sed` for file inspection
- Also prefer these installed tools when appropriate: `fzf`, `jq`, `tmux`, `shellcheck`, `ast-grep`, and `zoxide`.
- Fall back to POSIX tools only when the preferred tool is missing, portability is required, or the preferred tool cannot do the task cleanly. If falling back, state the reason briefly.
