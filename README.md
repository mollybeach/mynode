# mynode

Portable Node.js 22 LTS (v22.23.3) for macOS, for laptops where Node can't be installed. These are the official builds
from https://nodejs.org/dist/v22.23.3/, unchanged, with nodejs.org's published `SHASUMS256.txt`.

| File | Mac |
|------|-----|
| `node-v22.23.3-darwin-arm64.tar.xz` | Apple Silicon (M1 and later) |
| `node-v22.23.3-darwin-x64.tar.xz` | Intel |

## Use it

```bash
git clone git@github.com:mollybeach/mynode.git
cd mynode
./setup.command
```

Or double-click `setup.command`. It checks the file for this Mac against `SHASUMS256.txt`, unpacks it into
`./node`, and prints the one line to add to `~/.zshrc` so `node` and `npm` work in any Terminal. No admin rights
are needed and nothing is installed system-wide. To remove it, delete the folder and that line.

Node.js is MIT licensed; its license (`LICENSE`) is inside each archive.
