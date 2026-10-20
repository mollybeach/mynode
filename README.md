# mynode

Portable Node.js 22 LTS (v22.23.3) for macOS, for laptops where Node can't be installed. These are the official builds
from https://nodejs.org/dist/v22.23.3/, unchanged, with nodejs.org's published `SHASUMS256.txt`.

| File | Mac |
|------|-----|
| `node-v22.23.3-darwin-arm64.tar.xz` | Apple Silicon (M1 and later) |
| `node-v22.23.3-darwin-x64.tar.xz` | Intel |

## Jeremy: start ilovework

Your folders are `~/Desktop/Kiro/Jeremy_Guzman/mynode` and `~/Desktop/Kiro/Jeremy_Guzman/ilovework`. Run this one command in Terminal:

```bash
cd ~/Desktop/Kiro/Jeremy_Guzman && ./mynode/ilovework-runtime/install.command
```

From the `Jeremy_Guzman` folder, it copies `dist/` (the prebuilt app, Next.js included), `runtime/` (Node) and
`start.command` from `mynode` into `ilovework`, then starts the app at http://localhost:3000. No Node install, no npm and no
`next` needed. After that, start it any time with:

```bash
cd ~/Desktop/Kiro/Jeremy_Guzman/ilovework && ./start.command
```

## Jeremy: put `node` and `npm` on the PATH

After the installer has run once, Node and npm are in `ilovework/runtime/`. To use `node`, `npm` and `npx` in any
Terminal window, run this once:

```bash
A=$([ "$(uname -m)" = arm64 ] && echo arm64 || echo x64); echo "export PATH=\"$HOME/Desktop/Kiro/Jeremy_Guzman/ilovework/runtime/node-v22.23.3-darwin-$A/bin:\$PATH\"" >> ~/.zshrc && source ~/.zshrc && node -v && npm -v
```

It picks the folder for this Mac's chip, adds it to `~/.zshrc` and loads it. It should end by printing `v22.23.3` and
`10.9.9`. To remove older PATH lines from earlier attempts that point at `mynode`:

```bash
sed -i '' '/mynode\/node\/bin/d' ~/.zshrc
```

Running ilovework doesn't need this: `./start.command` finds its own Node.

## Optional: use mynode's own Node instead

Only needed for using `node` / `npm` yourself; ilovework doesn't need it.

```bash
cd ~/Desktop/Kiro/Jeremy_Guzman/mynode
./setup.command
sed -i '' '/Documents\/GitHub\/mynode/d' ~/.zshrc
grep -q 'Jeremy_Guzman/mynode/node/bin' ~/.zshrc || echo 'export PATH="$HOME/Desktop/Kiro/Jeremy_Guzman/mynode/node/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
node -v && npm -v
```

`setup.command` checks the Node file for this Mac against `SHASUMS256.txt` and unpacks it into `mynode/node` (press
Enter when it says so). The `sed` line removes an old PATH line that pointed at `~/Documents/GitHub/mynode`. The last
line should print `v22.23.3` and `10.9.9`. To remove it all, delete `mynode/node` and that line in `~/.zshrc`.

Node.js is MIT licensed; its license (`LICENSE`) is inside each archive.

## Troubleshooting: "npm not installed" / "command not found"

Paste this whole block into Terminal (it uses Jeremy's mynode folder, `~/Desktop/Kiro/Jeremy_Guzman/mynode`; change that path if yours is elsewhere):

```bash
echo "shell: $SHELL"
ls ~/Desktop/Kiro/Jeremy_Guzman/mynode/node/bin 2>&1
grep -n "mynode" ~/.zshrc ~/.bash_profile ~/.bashrc 2>/dev/null
echo "PATH: $PATH"
which node npm
~/Desktop/Kiro/Jeremy_Guzman/mynode/node/bin/node -v 2>&1
~/Desktop/Kiro/Jeremy_Guzman/mynode/node/bin/npm -v 2>&1
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

More on the ilovework files (what `start.command` does, keeping it out of git): `ilovework-runtime/README.md`.
