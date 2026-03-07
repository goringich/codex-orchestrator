# codex-orchestrator

User-level orchestration layer for Codex workers on this machine.

## Purpose
- manage background Codex work through an explicit queue
- keep runtime state, logs, and artifacts out of the home root
- integrate with the existing Hyprland/Rofi/system-bootstrap workflow

## Components
- `bin/codex-agent-enqueue`
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
codex-agent-status
codex-agent-enqueue --title "next-pass" --workdir ~/system-bootstrap < prompt.txt
codex-agent-run
```

The timer can also process queued tasks automatically.
