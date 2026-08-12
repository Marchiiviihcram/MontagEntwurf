#!/usr/bin/env zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

if ! command -v python3 >/dev/null 2>&1; then
  echo "[ERROR] python3 not found. Please install Python 3 first."
  exit 1
fi

if [[ ! -d .venv ]]; then
  echo "[INFO] Creating virtual environment: .venv"
  python3 -m venv .venv
fi

echo "[INFO] Installing/Updating PlatformIO in .venv"
./.venv/bin/python -m pip install --upgrade pip platformio

echo "[INFO] Tool versions"
./.venv/bin/python --version
./.venv/bin/pio --version

echo "[DONE] Local environment is ready."