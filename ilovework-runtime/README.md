# ilovework-runtime

Drop-in files that let an ilovework checkout start with no Node install and no npm:

- `start.command`: double-click (or `./start.command`) to start the app.
- `runtime/`: the official Node.js 22 LTS (v22.23.3) for Apple Silicon and Intel, with nodejs.org's `SHASUMS256.txt`.
- `dist/`: the prebuilt ilovework app, with Next.js and everything it needs inside. `install.command` copies it in
  when the ilovework folder has neither `dist/` nor `node_modules/`, which is what "next: command not found" means.
- `install.command`: puts all of the above in place and starts the app (see Quick start).

## Quick start

Put mynode and ilovework side by side in the same folder, for example your Kiro workspace:

```
YourWorkspace/          <- run the command from here
├── mynode/
└── ilovework/
```

Then, in Terminal, from that folder, run the installer:

```bash
./mynode/ilovework-runtime/install.command
```

Example: Jeremy's folders are `~/Desktop/Kiro/Jeremy_Guzman/mynode` and `~/Desktop/Kiro/Jeremy_Guzman/ilovework`, so he runs:

1. Go to the folder that holds `mynode` and `ilovework`:

   ```bash
   cd ~/Desktop/Kiro/Jeremy_Guzman
   ```

2. Run the installer:

   ```bash
   ./mynode/ilovework-runtime/install.command
   ```

and afterwards starts the app with:

```bash
cd ~/Desktop/Kiro/Jeremy_Guzman/ilovework && ./start.command
```

That's it. It finds `ilovework` next to `mynode`, copies `start.command`, `runtime/` and (if missing) `dist/` into it, tells git to ignore
the unpacked Node, and starts the app at http://localhost:3000. No Node install and no npm needed. After that, start
the app any time with `./start.command` inside the ilovework folder.

If ilovework isn't next to mynode, the installer searches your home folder for it, or you can give the path:
`./mynode/ilovework-runtime/install.command ~/path/to/ilovework`.

## Or do it by hand

```bash
# 1. Go to the folder that holds mynode and ilovework (Jeremy's: ~/Desktop/Kiro/Jeremy_Guzman)
cd ~/Desktop/Kiro/Jeremy_Guzman

# 2. Copy the two pieces into ilovework
cp -R mynode/ilovework-runtime/runtime mynode/ilovework-runtime/start.command ilovework/

# 3. Tell git to ignore the Node it unpacks
cd ilovework
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
