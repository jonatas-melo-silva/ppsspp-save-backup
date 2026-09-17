#!/usr/bin/env bash
set -uo pipefail
# sem -e aqui: o loop não pode morrer por causa de um erro pontual do inotifywait

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_DIR"

for dir in "$REPO_DIR/SAVEDATA" "$REPO_DIR/PPSSPP_STATE"; do
    if [ ! -d "$dir" ]; then
        echo "erro: pasta não encontrada: $dir" >&2
        exit 1
    fi
done

if ! command -v inotifywait >/dev/null 2>&1; then
    echo "erro: inotifywait não encontrado. instale com: sudo apt install inotify-tools" >&2
    exit 1
fi

echo "observando $REPO_DIR/SAVEDATA e $REPO_DIR/PPSSPP_STATE..."

while true; do
    inotifywait -r -e modify,create,delete,move \
        "$REPO_DIR/SAVEDATA" "$REPO_DIR/PPSSPP_STATE"

    echo "mudança detectada, aguardando 15s..."
    sleep 15

    "$REPO_DIR/scripts/backup.sh"
done
