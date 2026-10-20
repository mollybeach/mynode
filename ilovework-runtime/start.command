#!/bin/bash
# Double-click to start ilovework (or run ./start.command). No admin rights and no npm needed to run it: it uses the
# Node on this Mac if there is one (18.18+), otherwise the official Node bundled in runtime/.
#   - With a prebuilt dist/ (the iloveworky edition): runs dist/server.js.
#   - Otherwise, with node_modules/ already there (a normal checkout): runs next dev.
cd "$(dirname "$0")" || exit 1
NODE_VERSION=v22.23.3

node_ok() { "$1" -e 'const [a,b]=process.versions.node.split(".").map(Number); process.exit(a>18||(a===18&&b>=18)?0:1)' 2>/dev/null; }

NODE=""
if command -v node >/dev/null && node_ok node; then
  NODE="node"
else
  case "$(uname -m)" in arm64) ARCH=arm64 ;; *) ARCH=x64 ;; esac
  DIR="runtime/node-$NODE_VERSION-darwin-$ARCH"
  if [ ! -x "$DIR/bin/node" ]; then
    echo "First run: unpacking the bundled Node ($NODE_VERSION, $ARCH)..."
    tar -xJf "runtime/node-$NODE_VERSION-darwin-$ARCH.tar.xz" -C runtime || { echo "Couldn't unpack runtime/node-$NODE_VERSION-darwin-$ARCH.tar.xz"; read -r; exit 1; }
    xattr -dr com.apple.quarantine "$DIR" 2>/dev/null
  fi
  NODE="$DIR/bin/node"
  export PATH="$(pwd)/$DIR/bin:$PATH"   # so anything the app spawns (npx, node) finds the same Node
fi

PORT="${PORT:-3000}"
[ -z "$ILOVEWORK_NO_OPEN" ] && (sleep 4 && open "http://localhost:$PORT") &
if [ -f dist/server.js ]; then
  echo "Starting ilovework on http://localhost:$PORT with $("$NODE" -v) (close this window to stop it)"
  PORT="$PORT" HOSTNAME=127.0.0.1 NODE_ENV=production exec "$NODE" dist/server.js
elif [ -f node_modules/next/dist/bin/next ]; then
  echo "Starting ilovework (dev) on http://localhost:$PORT with $("$NODE" -v) (close this window to stop it)"
  exec "$NODE" node_modules/next/dist/bin/next dev --turbopack -p "$PORT"
else
  echo "This folder has neither dist/ nor node_modules/: copy start.command and runtime/ into the ilovework folder itself."
  read -r; exit 1
fi
