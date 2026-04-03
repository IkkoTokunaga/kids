#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
FILE="$ROOT/games/oekaki-hiroba.html"
JSON="$ROOT/games/oekaki-stamps.json"

test -f "$FILE" || { echo "FAIL: missing $FILE"; exit 1; }
test -f "$JSON" || { echo "FAIL: missing $JSON"; exit 1; }

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
check 'popup-title">スタンプ</p>'
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
check "renderStampAccordion"
check "buildStampUI"
check "stamp-tabs"
check "data-stamp-tab"
check "oekaki-stamps.json"
check "stampsJsonUrl"
check "setStampTab"
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
check "こうえん"
check "どうぶつえん"
check "すいぞくかん"
check "びょういん"
check "ショッピング"
check "さばんな"
check "がっこう"
check "やま"
check "ビーチ"
check "drawKouenTemplate"
check "drawZooTemplate"
check "drawAquariumTemplate"
check "drawHospitalTemplate"
check "drawShoppingTemplate"
check "drawSavannaTemplate"
check "drawSchoolTemplate"
check "drawMountainTemplate"
check "drawBeachTemplate"
check "bindPopupControls"
check "closeAllPopups"
check "bgCanvas"
check "var ctx = bgCtx;"
check "ResizeObserver"
check "resizeSnapshotDraw"

python3 - <<PY
import json
from pathlib import Path
data = json.loads(Path("$JSON").read_text(encoding="utf-8"))
tabs = data.get("tabs")
assert isinstance(tabs, list) and len(tabs) >= 9, "tabs"
labels = {t.get("label") for t in tabs}
assert "かお・きもち" in labels
seen = set()
total = 0
for t in tabs:
    st = t.get("stamps") or []
    for c in st:
        assert c not in seen, f"duplicate char in json: {c!r}"
        seen.add(c)
        total += 1
assert total >= 4000, f"expected full emoji set (~5k), got {total}"
PY

echo "OK: oekaki-hiroba.html checks passed"
