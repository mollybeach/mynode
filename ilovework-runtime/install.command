#!/bin/bash
# Copies start.command, runtime/ (Node) and, if it's missing, dist/ (the prebuilt app with Next.js) into an ilovework
# folder, then starts it. Works from wherever mynode was cloned.
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
mkdir -p "$I/runtime"
cp "$SRC"/runtime/* "$I/runtime/" && cp "$SRC/start.command" "$I/" && chmod +x "$I/start.command" || { echo "Copy failed."; read -r; exit 1; }
# The prebuilt app (Next.js included) when this ilovework doesn't have it yet, so it runs without npm or node_modules.
if [ ! -f "$I/dist/server.js" ] && [ ! -f "$I/node_modules/next/dist/bin/next" ]; then
  echo "Adding the prebuilt app (dist/, includes Next.js)"
  cp -R "$SRC/dist" "$I/dist" || { echo "Copy of dist/ failed."; read -r; exit 1; }
fi
grep -qx '/runtime/node-\*/' "$I/.gitignore" 2>/dev/null || printf '\n/runtime/node-*/\n' >> "$I/.gitignore"
cd "$I" && exec ./start.command
