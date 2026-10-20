# runtime/

Official Node.js 22 LTS (v22.23.3) for macOS, from https://nodejs.org/dist/v22.23.3/ (checked against the
published SHASUMS256.txt, included here). `start.command` uses it only when Node isn't installed: on first run it
unpacks the build for this Mac (arm64 = Apple Silicon, x64 = Intel) into `runtime/node-v22.23.3-darwin-<arch>/`,
which git ignores. Nothing is installed system-wide and no admin rights are needed.
