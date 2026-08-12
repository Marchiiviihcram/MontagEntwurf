#!/usr/bin/env zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

if [[ ! -x ./.venv/bin/pio ]]; then
  echo "[INFO] PlatformIO not found in .venv, running setup..."
  ./scripts/setup_env.sh
fi

if [[ $# -ge 1 ]]; then
  echo "[STEP] Opening serial monitor on port: $1"
  ./.venv/bin/pio device monitor --baud 115200 --port "$1"
else
  echo "[STEP] Opening serial monitor on auto-detected port"
  ./.venv/bin/pio device monitor --baud 115200
fi