#!/bin/bash
# Double-click (or ./setup.command) to unpack Node 22 for this Mac into ./node. No admin rights, nothing installed
# system-wide. Afterwards use ./node/bin/node and ./node/bin/npm, or add this folder's node/bin to your PATH.
cd "$(dirname "$0")" || exit 1
V=v22.23.3
case "$(uname -m)" in arm64) ARCH=arm64 ;; *) ARCH=x64 ;; esac
FILE="node-$V-darwin-$ARCH.tar.xz"
echo "Checking $FILE against SHASUMS256.txt..."
grep " $FILE\$" SHASUMS256.txt | shasum -a 256 -c - || { echo "Checksum doesn't match: don't use this file."; read -r; exit 1; }
rm -rf "node-$V-darwin-$ARCH" node
tar -xJf "$FILE" && mv "node-$V-darwin-$ARCH" node && xattr -dr com.apple.quarantine node 2>/dev/null
echo
echo "Node is ready: $(./node/bin/node -v) at $(pwd)/node/bin"
echo "To use it in Terminal, add this line to ~/.zshrc, then open a new Terminal window:"
echo "  export PATH=\"$(pwd)/node/bin:\$PATH\""
read -r -p "Press Enter to close."
