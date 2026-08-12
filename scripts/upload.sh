#!/usr/bin/env zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

if [[ ! -x ./.venv/bin/pio ]]; then
  echo "[INFO] PlatformIO not found in .venv, running setup..."
  ./scripts/setup_env.sh
fi

if [[ $# -ge 1 ]]; then
  echo "[STEP] Uploading to port: $1"
  ./.venv/bin/pio run -t upload --upload-port "$1"
else
  echo "[STEP] Uploading with auto-detected port"
  ./.venv/bin/pio run -t upload
fi

echo "[DONE] Upload finished."