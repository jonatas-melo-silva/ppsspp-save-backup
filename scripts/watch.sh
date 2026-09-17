#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

while true; do
    inotifywait -r -e modify,create,delete,move \
        "$REPO_DIR/SAVEDATA" "$REPO_DIR/PPSSPP_STATE" >/dev/null 2>&1

    # espera as escritas do jogo terminarem antes de commitar
    sleep 15

    "$REPO_DIR/scripts/backup.sh"
done
