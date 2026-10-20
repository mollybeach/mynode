#!/bin/bash
# Puts node, npm and npx on the Terminal PATH (in ~/.zshrc). Run it from anywhere:
#   ~/Desktop/Kiro/Jeremy_Guzman/mynode/add-to-path.command
# Unpacks this Mac's Node into mynode/node first if it isn't there yet (checked against SHASUMS256.txt).
cd "$(dirname "$0")" || exit 1
V=v22.23.3
case "$(uname -m)" in arm64) ARCH=arm64 ;; *) ARCH=x64 ;; esac
BIN="$(pwd)/node/bin"

if [ ! -x "$BIN/node" ]; then
  FILE="node-$V-darwin-$ARCH.tar.xz"
  echo "Unpacking $FILE..."
  grep " $FILE\$" SHASUMS256.txt | shasum -a 256 -c - >/dev/null || { echo "Checksum doesn't match: stopping."; exit 1; }
  tar -xJf "$FILE" && mv "node-$V-darwin-$ARCH" node && xattr -dr com.apple.quarantine node 2>/dev/null
fi

touch ~/.zshrc
# Drop older mynode PATH lines (from earlier attempts), then add the one for this folder.
sed -i '' '/mynode\/node\/bin/d' ~/.zshrc
echo "export PATH=\"$BIN:\$PATH\"" >> ~/.zshrc

export PATH="$BIN:$PATH"
echo "Added to ~/.zshrc: export PATH=\"$BIN:\$PATH\""
echo "node $("$BIN/node" -v), npm $("$BIN/npm" -v)"
echo
echo "Now open a new Terminal window (or run: source ~/.zshrc), then node -v and npm -v work anywhere."
