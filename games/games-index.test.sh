#!/usr/bin/env bash
# games/index.html のトップ画面チェック
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FILE="$ROOT/games/index.html"

test -f "$FILE" || { echo "FAIL: missing $FILE"; exit 1; }

first_link=$(grep -o 'href="[^"]*\.html"' "$FILE" | head -n 1)
if [[ "$first_link" != 'href="seikatsu-manner-game.html"' ]]; then
  echo "FAIL: first game link must be seikatsu-manner-game.html, got: $first_link"
  exit 1
fi

check() {
  if ! grep -qF "$1" "$FILE"; then
    echo "FAIL: expected in index.html: $1"
    exit 1
  fi
}

check "せいかつマナー すごろく"
check "suuji-quiz-game.html"
check "moji-kotoba-game.html"
check "oekaki-hiroba.html"
check "あそびを えらんでね"
check 'href="/favicon.svg"'

test -f "$ROOT/games/soon.html" || { echo "FAIL: missing soon.html"; exit 1; }

echo "OK: games index and soon page checks passed"
