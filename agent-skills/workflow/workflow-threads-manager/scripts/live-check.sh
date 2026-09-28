#!/usr/bin/env bash
# Is the live game actually working? Fetches the page, then the scripts and art it references, plus any extra paths.
# A page that returns 200 while its art returns 404 is a broken deploy (for example one shipped without its edge function).
#   live-check.sh <url> [extra-path ...]      (or set LIVE_URL)
set -uo pipefail
URL="${1:-${LIVE_URL:-}}"; [ -n "$URL" ] || { echo "usage: live-check.sh <url> [extra-path ...]"; exit 1; }; shift || true
URL="${URL%/}"
tmp=$(mktemp)
code=$(curl -s -o "$tmp" -w '%{http_code}' "$URL/")
echo "page  $URL/  $code  $(wc -c < "$tmp" | tr -d ' ') B"
paths=$(grep -oE '(src|href)="/[^"]+"' "$tmp" | sed -E 's/^(src|href)="//; s/"$//' | grep -vE '^//' | sort -u | head -8)
bad=0
for p in $paths "$@"; do
  c=$(curl -s -o /dev/null -w '%{http_code} %{size_download}B %{content_type}' "$URL$p")
  echo "      $p  $c"
  case "$c" in 2*) ;; *) bad=$((bad+1)) ;; esac
done
rm -f "$tmp"
[ "$bad" = 0 ] && echo "OK: page and every checked file load" || echo "BROKEN: $bad checked file(s) did not return 2xx"
