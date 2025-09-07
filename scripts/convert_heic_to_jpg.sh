#!/usr/bin/env bash
set -euo pipefail

# Batch convert .HEIC -> .jpg and update index.html references.

converted=0
while IFS= read -r -d '' f; do
  base="${f%.*}"
  out="${base}.jpg"
  if [[ ! -f "$out" ]]; then
    echo "Converting: $f -> $out"
    sips -s format jpeg "$f" --out "$out" >/dev/null
    ((converted++)) || true
  else
    echo "Skip (exists): $out"
  fi
  old_rel="${f#./}"
  new_rel="${out#./}"
  if [[ -f index.html ]]; then
    # Escape for sed: regex metacharacters in pattern; & and @ in replacement
    safe_pat=$(printf '%s' "$old_rel" | sed -e 's/[\\.^$*+?()\[\]{}|]/\\&/g' -e 's/@/\\@/g')
    safe_repl=$(printf '%s' "$new_rel" | sed -e 's/[&]/\\&/g' -e 's/@/\\@/g')
    sed -i '' -e "s@${safe_pat}@${safe_repl}@g" index.html
  fi
done < <(find . -maxdepth 2 -type f -name '*.HEIC' -print0)

echo "Converted: ${converted} file(s)."
