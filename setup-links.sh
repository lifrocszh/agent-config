#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd "$(dirname "$0")" && pwd -P)
backup_dir=""

link_path() {
  source_path=$1
  target_path=$2
  backup_path=$3

  if [ ! -e "$source_path" ]; then
    printf 'Missing source: %s\n' "$source_path" >&2
    exit 1
  fi

  mkdir -p "$(dirname "$target_path")"

  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    printf 'Already linked: %s\n' "$target_path"
    return
  fi

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    if [ -z "$backup_dir" ]; then
      backup_dir="$HOME/.agent-config-backup-$(date '+%Y-%m-%d-%H%M%S')"
    fi
    mkdir -p "$(dirname "$backup_dir/$backup_path")"
    mv "$target_path" "$backup_dir/$backup_path"
    printf 'Backed up: %s\n' "$target_path"
  fi

  ln -s "$source_path" "$target_path"
  printf 'Linked: %s\n' "$target_path"
}

link_path "$repo_dir/AGENTS.md" "$HOME/.codex/AGENTS.md" ".codex/AGENTS.md"
link_path "$repo_dir/AGENTS.md" "$HOME/.pi/agent/AGENTS.md" ".pi/agent/AGENTS.md"
link_path "$repo_dir/home/.agents/skills" "$HOME/.agents/skills" ".agents/skills"
link_path "$repo_dir/home/.pi/agent/APPEND_SYSTEM.md" "$HOME/.pi/agent/APPEND_SYSTEM.md" ".pi/agent/APPEND_SYSTEM.md"
link_path "$repo_dir/home/.pi/agent/agents" "$HOME/.pi/agent/agents" ".pi/agent/agents"
link_path "$repo_dir/home/.pi/agent/prompts" "$HOME/.pi/agent/prompts" ".pi/agent/prompts"
link_path "$repo_dir/home/.tmux.conf" "$HOME/.tmux.conf" ".tmux.conf"

printf 'Shared links ready. Merge Codex/Pi settings templates manually; no packages were installed.\n'
