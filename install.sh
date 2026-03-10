#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_HOME="${TARGET_HOME:-$HOME}"
ENABLE_TIMER="${CODEX_ORCHESTRATOR_ENABLE_TIMER:-1}"

install -d -m 755 \
  "$TARGET_HOME/.local/bin" \
  "$TARGET_HOME/.config/codex-orchestrator" \
  "$TARGET_HOME/.config/systemd/user" \
  "$TARGET_HOME/.local/share/applications" \
  "$TARGET_HOME/__home_organized/runtime/codex-orchestrator/queue" \
  "$TARGET_HOME/__home_organized/runtime/codex-orchestrator/claims" \
  "$TARGET_HOME/__home_organized/runtime/codex-orchestrator/done" \
  "$TARGET_HOME/__home_organized/runtime/codex-orchestrator/failed" \
  "$TARGET_HOME/__home_organized/logs/codex-orchestrator" \
  "$TARGET_HOME/__home_organized/artifacts/codex-orchestrator"

install -m 755 "$REPO_ROOT/bin/codex-agent-run" "$TARGET_HOME/.local/bin/codex-agent-run"
install -m 755 "$REPO_ROOT/bin/codex-agent-enqueue" "$TARGET_HOME/.local/bin/codex-agent-enqueue"
install -m 755 "$REPO_ROOT/bin/codex-agent-enqueue-system" "$TARGET_HOME/.local/bin/codex-agent-enqueue-system"
install -m 755 "$REPO_ROOT/bin/codex-agent-status" "$TARGET_HOME/.local/bin/codex-agent-status"
install -m 755 "$REPO_ROOT/bin/codex" "$TARGET_HOME/.local/bin/codex"

install -m 644 "$REPO_ROOT/config/manager-prompt.txt" "$TARGET_HOME/.config/codex-orchestrator/manager-prompt.txt"

install -m 644 "$REPO_ROOT/systemd/codex-agent-orchestrator.service" \
  "$TARGET_HOME/.config/systemd/user/codex-agent-orchestrator.service"
install -m 644 "$REPO_ROOT/systemd/codex-agent-orchestrator.timer" \
  "$TARGET_HOME/.config/systemd/user/codex-agent-orchestrator.timer"

install -m 644 "$REPO_ROOT/applications/codex-agent-orchestrator-run.desktop" \
  "$TARGET_HOME/.local/share/applications/codex-agent-orchestrator-run.desktop"
install -m 644 "$REPO_ROOT/applications/codex-agent-orchestrator-status.desktop" \
  "$TARGET_HOME/.local/share/applications/codex-agent-orchestrator-status.desktop"

if [[ "${ENABLE_TIMER}" == "1" && "${TARGET_HOME}" == "${HOME}" ]] && command -v systemctl >/dev/null 2>&1; then
  systemctl --user daemon-reload
  systemctl --user enable --now codex-agent-orchestrator.timer
fi

echo "codex-orchestrator installed into $TARGET_HOME"
