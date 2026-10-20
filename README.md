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

## Troubleshooting: "npm not installed" / "command not found"

Paste this whole block into Terminal (it assumes the clone is at `~/mynode`; change that path if yours is elsewhere):

```bash
echo "shell: $SHELL"
ls ~/mynode/node/bin 2>&1
grep -n "mynode" ~/.zshrc ~/.bash_profile ~/.bashrc 2>/dev/null
echo "PATH: $PATH"
which node npm
~/mynode/node/bin/node -v 2>&1
~/mynode/node/bin/npm -v 2>&1
```

What each line tells you:

- `ls`: whether `setup.command` actually unpacked Node. "No such file" means it didn't run, or `mynode` is somewhere else.
- `grep`: whether the PATH line was added, and to which file. If your shell is bash rather than zsh, `~/.zshrc` is never read: add the line to `~/.bash_profile` instead.
- `which`: whether Terminal can find `node` and `npm` on its path.
- The last two: whether Node works at all when called by its full path. If these print versions but plain `npm` doesn't, only the PATH line needs fixing.

Running ilovework doesn't need npm at all: `npm install` and `npm run dev` are only for changing its code. In the ilovework folder:

```bash
git pull
./start.command
```

`start.command` never uses npm. It uses the Node bundled in that repo, so the app starts even while the Terminal path is broken.

## For ilovework: one command

Put mynode and ilovework side by side in the same folder, then from that folder run:

```bash
git -C mynode pull && ./mynode/ilovework-runtime/install.command
```

Example: Jeremy's folders are `~/Desktop/Kiro/Jeremy_Guzman/mynode` and `~/Desktop/Kiro/Jeremy_Guzman/ilovework`, so he runs:

```bash
cd ~/Desktop/Kiro/Jeremy_Guzman
git -C mynode pull && ./mynode/ilovework-runtime/install.command
```

and afterwards starts the app with:

```bash
cd ~/Desktop/Kiro/Jeremy_Guzman/ilovework && ./start.command
```

It copies the launcher and this Node into ilovework and starts the app (no Node install, no npm). Details:
`ilovework-runtime/README.md`.
