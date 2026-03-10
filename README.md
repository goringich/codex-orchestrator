# codex-orchestrator

User-level orchestration layer for Codex workers on this machine.

## Purpose
- manage background Codex work through an explicit queue
- keep runtime state, logs, and artifacts out of the home root
- integrate with the existing Hyprland/Rofi/system-bootstrap workflow

## Components
- `bin/codex` - orchestration-aware wrapper for the user-facing `codex` command
- `bin/codex-agent-enqueue`
- `bin/codex-agent-enqueue-system`
- `bin/codex-agent-run`
- `bin/codex-agent-status`
- `config/manager-prompt.txt`
- `systemd/codex-agent-orchestrator.service`
- `systemd/codex-agent-orchestrator.timer`
- `applications/*.desktop`

## Install

```bash
cd ~/codex-orchestrator
./install.sh
```

This installs:
- `codex` wrapper into `~/.local/bin` so future shell sessions hit the orchestrated entrypoint first
- scripts into `~/.local/bin`
- config into `~/.config/codex-orchestrator`
- user systemd units into `~/.config/systemd/user`
- desktop entries into `~/.local/share/applications`
- runtime roots under `~/__home_organized`

## Runtime Paths
- queue: `~/__home_organized/runtime/codex-orchestrator/queue`
- claims: `~/__home_organized/runtime/codex-orchestrator/claims`
- done: `~/__home_organized/runtime/codex-orchestrator/done`
- failed: `~/__home_organized/runtime/codex-orchestrator/failed`
- logs: `~/__home_organized/logs/codex-orchestrator`
- artifacts: `~/__home_organized/artifacts/codex-orchestrator`

## Usage

```bash
codex
codex queue-status
codex queue-add --title "next-pass" --workdir ~/system-bootstrap < prompt.txt
codex queue-system --title "system-next-pass" --workdir ~/system-bootstrap < prompt.txt
codex-agent-status
codex-agent-enqueue --title "next-pass" --workdir ~/system-bootstrap < prompt.txt
codex-agent-enqueue-system --title "system-next-pass" --workdir ~/system-bootstrap < prompt.txt
codex-agent-run
```

The timer can also process queued tasks automatically.

## Recommended Pattern

Use `codex queue-system` for machine-shaping work that spans existing system repositories.

That helper automatically scopes the worker to:
- `~/system-bootstrap`
- `~/codex-orchestrator`
- `~/custom-cachyos-iso`
- `~/Desktop/Obsidian`

It also preloads the expectation that the worker should inspect `Obsidian/System`, `System Blueprint`, and recent Codex conversation notes before making changes.

## Session Default

`install.sh` places a `codex` wrapper into `~/.local/bin/codex`.

That makes new interactive shell sessions resolve `codex` through this repo first, while still delegating actual interactive work to the real CLI at `/usr/bin/codex`.
