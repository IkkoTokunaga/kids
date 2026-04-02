#!/usr/bin/env bash
# Vercel 設定: ルート URL から favicon が届くこと
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
CFG="$ROOT/vercel.json"

test -f "$CFG" || { echo "FAIL: missing $CFG"; exit 1; }

if ! grep -q '"/favicon.svg"' "$CFG" || ! grep -q '"/games/favicon.svg"' "$CFG"; then
  echo "FAIL: vercel.json must rewrite /favicon.svg to /games/favicon.svg"
  exit 1
fi

echo "OK: vercel favicon rewrite present"
