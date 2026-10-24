#!/usr/bin/env bash
# Mechanical brand checks for DEMO_FREEX outputs.
#   tools/check-brand.sh <file>...   check given files
#   tools/check-brand.sh --all       check every output folder
#   tools/check-brand.sh --hook      PostToolUse hook: reads tool JSON on stdin
# Exit 0 = pass, 2 = fail (messages on stderr; Claude Code feeds them back to the agent).

ROOT="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "$ROOT" || exit 0

OUTPUT_DIRS="social site design design-system ops/drafts"
FORBIDDEN='demo[ _-]?fleex|demo[ _-]?freeks|demo[ _-]?920|made in italy|hillman|daimon|nato da un incontro'
# Drafts to Marta may name a term only to ask for its removal.
FORBIDDEN_DRAFTS='demo[ _-]?fleex|demo[ _-]?freeks|hillman|daimon|nato da un incontro'
IMG_EXT='png|jpe?g|svg|webp|gif|avif|pdf'

fail=0
err() { echo "check-brand: $1" >&2; fail=1; }

in_scope() {
  local f="${1#./}"
  for d in $OUTPUT_DIRS; do [[ "$f" == "$d/"* ]] && return 0; done
  return 1
}

check_file() {
  local f="${1#./}"
  [[ -f "$f" ]] || return 0
  case "$f" in *.png|*.jpg|*.jpeg|*.webp|*.gif|*.pdf|*.ttf|*.woff|*.woff2) return 0;; esac

  # 1. forbidden terms
  local pat="$FORBIDDEN"
  [[ "$f" == ops/drafts/* ]] && pat="$FORBIDDEN_DRAFTS"
  [[ "$f" == design-system/inventory.md ]] && pat="$FORBIDDEN_DRAFTS"  # inventory cites source file names
  grep -inE "$pat" "$f" | while IFS= read -r l; do echo "check-brand: $f:${l%%:*}: forbidden term → ${l#*:}" >&2; done
  grep -iqE "$pat" "$f" && fail=1

  # 2. Instagram captions: ```caption blocks — lowercase, max 2 lines, no hashtags
  if [[ "$f" == social/* && "$f" == *.md ]]; then
    local out
    out=$(awk -v F="$f" '
      /^```caption[[:space:]]*$/ { inb=1; n=0; start=NR; next }
      inb && /^```[[:space:]]*$/ { if (n>2) printf "%s:%d: caption has %d lines (max 2)\n", F, start, n; inb=0; next }
      inb {
        if ($0 ~ /[^[:space:]]/) n++
        line=$0; gsub(/DEMO_FREEX/, "", line)
        if (line ~ /#[[:alnum:]_]/) printf "%s:%d: hashtag in caption\n", F, NR
        if (line ~ /[A-ZÀ-Ý]/) printf "%s:%d: uppercase in caption\n", F, NR
      }' "$f")
    [[ -n "$out" ]] && { echo "$out" | sed 's/^/check-brand: /' >&2; fail=1; }
  fi

  # 3. site/ and design/src: assets must be inventoried, colours must be tokens
  if [[ "$f" == site/* || "$f" == design/src/* ]]; then
    local inv=design-system/inventory.md tok=design-system/tokens.css ref base
    while IFS= read -r ref; do
      [[ "$ref" =~ ^(https?:|data:|//) ]] && continue
      base=$(basename "$ref")
      grep -qF "$base" "$inv" 2>/dev/null || err "$f: asset not in inventory → $ref"
    done < <(grep -oE "[^\"'( ]+\.($IMG_EXT)" "$f" | sort -u)
    if [[ "$f" =~ \.(css|html|js|svg)$ && -f "$tok" ]]; then
      local allowed hex
      allowed=$(grep -oiE '#[0-9a-f]{3,8}\b' "$tok" | tr 'A-F' 'a-f' | sort -u)
      while IFS= read -r hex; do
        echo "$allowed" | grep -qx "$hex" || err "$f: colour not in tokens → $hex"
      done < <(grep -oiE '#[0-9a-f]{6}\b|#[0-9a-f]{3}\b' "$f" | tr 'A-F' 'a-f' | sort -u)
    fi
  fi
}

files=()
case "$1" in
  --hook)
    input=$(cat)
    p=$(printf '%s' "$input" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*:[[:space:]]*"(.*)"/\1/')
    [[ -z "$p" ]] && exit 0
    p="${p#$ROOT/}"
    in_scope "$p" || exit 0
    files=("$p") ;;
  --all)
    while IFS= read -r x; do files+=("$x"); done < <(find $OUTPUT_DIRS -type f 2>/dev/null) ;;
  *) files=("$@") ;;
esac

for f in "${files[@]}"; do check_file "$f"; done
if [[ $fail -ne 0 ]]; then
  echo "check-brand: FAIL — fix before handing off (rules: .claude/skills/brand/SKILL.md, design-system/inventory.md)" >&2
  exit 2
fi
exit 0
