#!/usr/bin/env bash
set -euo pipefail

# roda sempre a partir da raiz do repositório, não importa de onde foi chamado
cd "$(dirname "$0")/.."

if [ -z "$(git status --porcelain)" ]; then
    exit 0
fi

git add .
git commit -m "backup automático: $(date '+%Y-%m-%d %H:%M:%S')"
git push
