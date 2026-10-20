# ilovework-runtime

Drop-in files that let an ilovework checkout start with no Node install and no npm:

- `start.command`: double-click (or `./start.command`) to start the app.
- `runtime/`: the official Node.js 22 LTS (v22.23.3) for Apple Silicon and Intel, with nodejs.org's `SHASUMS256.txt`.

## Add them to an ilovework folder

```bash
# 1. Get mynode (first time), or update it if you already have it
git clone git@github.com:mollybeach/mynode.git ~/mynode
cd ~/mynode && git pull

# 2. Copy the two pieces into your ilovework folder (change the path to where yours is)
cp -R ~/mynode/ilovework-runtime/runtime ~/mynode/ilovework-runtime/start.command ~/Documents/git/ilovework/

# 3. Tell git to ignore the Node it unpacks
cd ~/Documents/git/ilovework
grep -qx '/runtime/node-\*/' .gitignore || printf '\n/runtime/node-*/\n' >> .gitignore

# 4. Start it (or double-click start.command in Finder)
./start.command
```

The first run unpacks Node, then opens http://localhost:3000. If something else is already using port 3000, run
`PORT=3005 ./start.command`.

## How the launcher works

- **Node:** it uses the Mac's own Node if there is one (18.18 or newer), otherwise the bundled one.
- **With a prebuilt `dist/`** (like the iloveworky edition): it runs that.
- **Without `dist/`** (a normal ilovework checkout): it runs `next dev` from the folder's existing `node_modules/`. So
  `node_modules/` still has to be there, but neither Node nor npm has to be installed to start the app.

## Keep it out of git (optional)

If you commit `start.command`, `runtime/` and the `.gitignore` line, they're pushed with everything else: about 53 MB
added to the repo. To keep them only on this computer, add these two lines to the ilovework folder's
`.git/info/exclude` instead:

```
/runtime/
/start.command
```
