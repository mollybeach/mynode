# ilovework-runtime

Drop-in files that let an ilovework checkout start with no Node install and no npm:

- `start.command`: double-click (or `./start.command`) to start the app. It uses the Mac's Node if there is one,
  otherwise the Node bundled in `runtime/`. With a prebuilt `dist/` it runs that; otherwise it runs `next dev` from an
  existing `node_modules/`.
- `runtime/`: the official Node.js 22 LTS (v22.23.3) for Apple Silicon and Intel, with nodejs.org's `SHASUMS256.txt`.

## Add them to an ilovework folder

```bash
cd ~/mynode && git pull                                  # or: git clone git@github.com:mollybeach/mynode.git ~/mynode
cp -R ~/mynode/ilovework-runtime/runtime ~/mynode/ilovework-runtime/start.command PATH/TO/ilovework/
cd PATH/TO/ilovework
grep -qx '/runtime/node-\*/' .gitignore || printf '\n/runtime/node-*/\n' >> .gitignore
./start.command
```

The first run unpacks Node into `runtime/node-v22.23.3-darwin-<arch>/` (git ignores it), then opens
http://localhost:3000. Use another port with `PORT=3005 ./start.command`.

The iloveworky (Jeremy) repo already ships these files, so it doesn't need this.
