#!/usr/bin/env zsh
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

echo "=== Repository Status Snapshot ==="
echo "Time: $(date '+%Y-%m-%d %H:%M:%S %z')"
echo "Path: $ROOT_DIR"

echo "Branch: $(git rev-parse --abbrev-ref HEAD)"
echo "Commit: $(git rev-parse --short HEAD)"
echo "Last Commit: $(git log -1 --pretty=format:'%h %ad %s' --date=iso)"

if git diff --quiet && git diff --cached --quiet; then
  echo "Working Tree: clean"
else
  echo "Working Tree: dirty"
fi

echo "Remote: $(git remote get-url origin 2>/dev/null || echo 'not set')"
echo "--- git status --short ---"
git status --short

if [[ -x ./.venv/bin/pio ]]; then
  echo "PlatformIO: $(./.venv/bin/pio --version)"
else
  echo "PlatformIO: not installed in .venv"
fi