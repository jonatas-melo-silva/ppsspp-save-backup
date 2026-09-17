#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

if [ -z "${1:-}" ]; then
    echo "uso: $0 \"mensagem do checkpoint\""
    exit 1
fi

TAG="checkpoint-$(date '+%Y%m%d-%H%M%S')"

git add .
git commit -m "checkpoint: $1" --allow-empty
git tag -a "$TAG" -m "$1"
git push
git push origin "$TAG"

echo "checkpoint criado: $TAG"
