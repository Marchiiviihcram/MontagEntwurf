#!/usr/bin/env zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "[STEP] Pulling latest changes from origin/main"
git pull --rebase origin main

echo "[STEP] Setting up local environment"
./scripts/setup_env.sh

echo "[STEP] Building firmware"
./.venv/bin/pio run

echo "[DONE] Sync and build finished."