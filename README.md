# mynode

Portable Node.js 22 LTS (v22.23.3) for macOS, for laptops where Node can't be installed. These are the official builds
from https://nodejs.org/dist/v22.23.3/, unchanged, with nodejs.org's published `SHASUMS256.txt`.

| File | Mac |
|------|-----|
| `node-v22.23.3-darwin-arm64.tar.xz` | Apple Silicon (M1 and later) |
| `node-v22.23.3-darwin-x64.tar.xz` | Intel |

## Use it

Clone it into `~/tools` (a stable place outside your repos, Downloads and Desktop: the PATH line points at it, so it
has to stay put):

```bash
mkdir -p ~/tools
cd ~/tools
git clone git@github.com:mollybeach/mynode.git
cd mynode
./setup.command
```

Or double-click `setup.command`. It checks the file for this Mac against `SHASUMS256.txt`, unpacks it into
`./node`, and prints the one line to add to `~/.zshrc` so `node` and `npm` work in any Terminal. No admin rights
are needed and nothing is installed system-wide. To remove it, delete the folder and that line.

## Make `node` and `npm` work in Terminal

After `setup.command`:

1. From inside the `mynode` folder (wherever you cloned it), add it to `~/.zshrc`:

   ```bash
   echo "export PATH=\"$(pwd)/node/bin:\$PATH\"" >> ~/.zshrc
   ```

2. Load it, or open a new Terminal window: `source ~/.zshrc`
3. Check both: `node -v` should say `v22.23.3`, and `npm -v` should say `10.9.9`.

If they still say "command not found", find the folder with
`find ~ -maxdepth 5 -type d -path "*mynode/node/bin" 2>/dev/null`, make sure the `export PATH=...` line in `~/.zshrc`
points at it (remove any older one that points somewhere else), and open a new Terminal window.

Node.js is MIT licensed; its license (`LICENSE`) is inside each archive.
