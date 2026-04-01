#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FILE="$ROOT/games/oekaki-hiroba.html"

test -f "$FILE" || { echo "FAIL: missing $FILE"; exit 1; }

check() {
  if ! grep -qF "$1" "$FILE"; then
    echo "FAIL: expected: $1"
    exit 1
  fi
}

check "おえかき ひろば"
check 'href="/"'
check "drawCanvas"
check "ぜんぶ けす"
check "スタンプ（200しゅるい / いちらん）"
check "やみなべ"
check "テンプレート"
check "いろ"
check "タッチ"
check "data-popup-open"
check "popupStamps"
check "どうろ"
check "ケーキやさん"
check "ゆうえんち"
check "まちなみ"
check "うみ"
check "うちゅう"
check "おしろ"
check "おはなばたけ"
check "stampAccordion"
check "STAMPS"
check "renderStampAccordion"
check "スタンプ いちらん"
check "sprayAt"
check "data-kind=\"spray\""
check "placeStamp"
check 'ctx.font = "76px sans-serif"'
check "runYaminabe"
check "drawRoadTemplate"
check "drawCakeTemplate"
check "drawParkTemplate"
check "drawCityTemplate"
check "drawSeaTemplate"
check "drawSpaceTemplate"
check "drawCastleTemplate"
check "drawGardenTemplate"
check "bindPopupControls"
check "closeAllPopups"
check "bgCanvas"
check "var ctx = bgCtx;"
check "ResizeObserver"

echo "OK: oekaki-hiroba.html checks passed"
