#!/bin/bash
# Copies start.command and runtime/ into an ilovework folder, then starts it. Works from wherever mynode was cloned.
#   ./ilovework-runtime/install.command                 finds ilovework (next to mynode, or under your home folder)
#   ./ilovework-runtime/install.command /path/ilovework  uses that folder
SRC="$(cd "$(dirname "$0")" && pwd)"
M="$(cd "$SRC/.." && pwd)"
is_app() { [ -f "$1/package.json" ] && [ -d "$1/database" ] && [ -d "$1/src" ]; }

I="$1"
if [ -z "$I" ]; then
  if is_app "$M/../ilovework"; then
    I="$M/../ilovework"
  else
    echo "Looking for your ilovework folder..."
    while IFS= read -r d; do is_app "$d" && { I="$d"; break; }; done < <(find "$HOME" -maxdepth 6 -type d -name ilovework -not -path "*/node_modules/*" -not -path "*/Library/*" 2>/dev/null)
  fi
fi
[ -n "$I" ] && is_app "$I" || { echo "Couldn't find the ilovework folder. Run it again with the path, e.g.: ./ilovework-runtime/install.command ~/path/to/ilovework"; read -r; exit 1; }
I="$(cd "$I" && pwd)"

echo "Copying start.command and runtime/ into $I"
(cd "$M" && git pull -q 2>/dev/null)
mkdir -p "$I/runtime"
cp "$SRC"/runtime/* "$I/runtime/" && cp "$SRC/start.command" "$I/" && chmod +x "$I/start.command" || { echo "Copy failed."; read -r; exit 1; }
grep -qx '/runtime/node-\*/' "$I/.gitignore" 2>/dev/null || printf '\n/runtime/node-*/\n' >> "$I/.gitignore"
cd "$I" && exec ./start.command
