# agent-config

Personal, cross-workstation configuration source for Codex, Pi, shared skills, tmux, and a CLI inventory.

## Contents

- `AGENTS.md` is the shared base instruction file.
- `home/.agents/skills/` contains the skills and their supporting files.
- `home/.pi/agent/` contains Pi's shared prompt, agent, and system-addition files. `settings.shared.json` records shared preferences without machine identity fields.
- `home/.codex/config.toml` records portable Codex defaults. The current live Codex config also has Mac-specific project, desktop, notification, plugin, and MCP settings; merge this baseline after reviewing each workstation's config.
- `home/.tmux.conf` is the shared tmux config. Clipboard command switches between `pbcopy` on macOS and `clip.exe` when `WSL_DISTRO_NAME` is set.
- `tools.toml` is a human-maintained inventory only. It installs, upgrades, and removes nothing. WSL entries await inventory.

## Link the shared files

Clone the repository, then run the link setup. It creates the shared links and moves any existing target aside into a dated `$HOME/.agent-config-backup-*` directory. It does not install packages or edit Codex/Pi settings.

```sh
git clone https://github.com/lifrocszh/agent-config.git "$HOME/agent-config"
cd "$HOME/agent-config"
./setup-links.sh
```

`AGENTS.md` is linked into both Codex and Pi. `~/.agents/skills` is shared across compatible agents. The Pi agent definitions, prompts, system addition, and tmux config are linked directly.

Merge `home/.codex/config.toml` into the local Codex config after reviewing host-specific entries. It is a portable baseline, not a complete replacement for the machine's Codex config. Merge `home/.pi/agent/settings.shared.json` into the local Pi `settings.json`, preserving its device ID and local settings. Do not copy authentication files or machine identity values into this repository.

After `git pull`, linked files update in place. Start a new Codex session, run `/reload` in Pi, and reload tmux with its configured `prefix+r` binding. `tools.toml` remains informational; install or update CLI tools manually for each operating system.

## Local machine inventory

The Mac inventory reflects current top-level Homebrew formulae. `rg` currently resolves to the Codex CLI bundled binary. Add WSL tools and package-manager details after checking that environment. The inventory is a reference only; install or update tools manually.
