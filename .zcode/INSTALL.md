# AI Installation Guide for sw-agiledevelopment (ZCode)

This guide is written for an AI coding agent. When a user asks you to install
`sw-agiledevelopment` for **ZCode**, follow these steps and perform the work
yourself when you have permission.

## Goal

Install the `sw-agiledevelopment` plugin into the user's ZCode environment so
that the agile development skills are available globally in every ZCode session,
with the `sw-using-agiledevelopment` bootstrap content auto-injected on session
start.

## What this installs

- Marketplace source: `vaycentsun/sw-agiledevelopment`
- Plugin name: `sw-agiledevelopment`
- Plugin version: see the `VERSION` file (currently `1.3.2`)
- Plugin capabilities: **ZCode Skills only**. This plugin does not expose MCP
  tools or callable functions. It injects a bootstrap context via a `SessionStart`
  hook.

## How the plugin is structured

The plugin manifest lives at `.zcode-plugin/plugin.json` and declares
`"skills": "skills"`, pointing at the repository-root `skills/` directory (a set
of symlinks to the real `sw-*/` source directories). A `SessionStart` hook in
`.zcode-plugin/hooks/` reads `sw-using-agiledevelopment/SKILL.md` and injects it
into each new session — this is what makes the agile workflow reliably activate.

## Prerequisites

1. Confirm the user wants this installed in their ZCode environment.
2. Confirm a ZCode installation is present. Look for one of:
   - The `zcode` CLI on `PATH` (`zcode --version`), or
   - The ZCode config directory at `~/.zcode/cli/plugins/`.
3. Confirm `git`, `bash`/`zsh`, and `python3` are available (needed to clone,
   run the SessionStart hook, and update the ZCode config on Unix; on Windows
   the polyglot `run-hook.cmd` wrapper locates bash automatically).

If ZCode is not present at all, stop and tell the user ZCode must be installed
first.

## Install Steps

### Option A — Via ZCode marketplace (preferred when the CLI is available)

If the `zcode` CLI is available and exposes a plugin marketplace command, add
this repository as a marketplace and install the plugin. Run:

```bash
zcode plugin marketplace add vaycentsun/sw-agiledevelopment --ref main
```

Then open the ZCode plugin interface (`zcode plugin` or the `/plugins` panel
inside ZCode) and install `sw-agiledevelopment` from the `sw-agiledevelopment`
marketplace.

> If the CLI's marketplace subcommand names differ across versions, prefer
> whatever the CLI documents for "add a GitHub marketplace" / "install a plugin
> from a marketplace". Do not invent flags.

### Option B — Manual filesystem install (always works)

Use this when there is no `zcode` CLI or the marketplace command is unavailable.
ZCode discovers user plugins through `plugins.dirs` in
`~/.zcode/cli/config.json`, not through marketplace JSON files, so the install
follows that path.

#### One-step install (recommended)

Clone the repository, then run the installer script:

```bash
git clone https://github.com/vaycentsun/sw-agiledevelopment.git \
  "$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment"

bash "$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment/scripts/install-zcode.sh"
```

The script will create a versioned plugin cache matching ZCode's official layout,
register the plugin in `~/.zcode/cli/config.json`, and verify the SessionStart
hook. Then fully restart ZCode.

#### Manual equivalent

If you cannot run the installer script, do the same steps by hand:

```bash
# 1. Clone (or update) the source repository.
SRC="$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment"
if [ -d "$SRC/.git" ]; then
  git -C "$SRC" pull --ff-only
else
  git clone https://github.com/vaycentsun/sw-agiledevelopment.git "$SRC"
fi

# 2. Build a versioned plugin cache that mirrors the official layout.
VERSION=$(cat "$SRC/VERSION")
DST="$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment/sw-agiledevelopment/$VERSION"
rm -rf "$DST"
mkdir -p "$DST"

ln -s "../../../sw-agiledevelopment-src/sw-agiledevelopment/.zcode-plugin" "$DST/.zcode-plugin"
ln -s "../../../sw-agiledevelopment-src/sw-agiledevelopment/package.json" "$DST/package.json"
[ -f "$SRC/README.md" ] && ln -s "../../../sw-agiledevelopment-src/sw-agiledevelopment/README.md" "$DST/README.md"

mkdir -p "$DST/skills"
for d in "$SRC"/sw-*/; do
  name=$(basename "$d")
  ln -s "$(cd "$d" && pwd)" "$DST/skills/$name"
done

mkdir -p "$DST/hooks"
cp "$SRC/.zcode-plugin/hooks/run-hook.cmd" "$DST/hooks/run-hook.cmd"
cp "$SRC/.zcode-plugin/hooks/hooks.json" "$DST/hooks/hooks.json"
cat > "$DST/hooks/session-start" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
exec bash "${PLUGIN_ROOT}/.zcode-plugin/hooks/session-start" "$@"
EOF
chmod +x "$DST/hooks/session-start" "$DST/hooks/run-hook.cmd"

# 3. Register the plugin in ZCode's plugin config.
python3 - "$DST" "$HOME/.zcode/cli/config.json" <<'PY'
import json, os, sys
dst_dir = sys.argv[1]
config_path = sys.argv[2]

cfg = {}
if os.path.exists(config_path):
    with open(config_path, "r", encoding="utf-8") as f:
        cfg = json.load(f)
if not isinstance(cfg, dict):
    cfg = {}

cfg.setdefault("plugins", {})
cfg["plugins"]["enabled"] = True
existing = cfg["plugins"].get("dirs", [])
if not isinstance(existing, list):
    existing = []
existing = [d for d in existing if "sw-agiledevelopment/sw-agiledevelopment/" not in d]
cfg["plugins"]["dirs"] = [dst_dir] + existing

with open(config_path, "w", encoding="utf-8") as f:
    json.dump(cfg, f, indent=2, ensure_ascii=False)
    f.write("\n")
PY
```

## Verify installation

1. Confirm the plugin manifest is reachable:

```bash
cat "$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment/sw-agiledevelopment/$(cat "$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment/VERSION")/.zcode-plugin/plugin.json"
```

2. Confirm the SessionStart hook runs and emits valid JSON context:

```bash
DST="$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment/sw-agiledevelopment/$(cat "$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment/VERSION")"
bash "$DST/hooks/session-start" | python3 -m json.tool > /dev/null && echo "hook OK"
```

This should print `hook OK`. If it prints nothing or errors, the skills path or
symlinks are wrong — re-check that the clone is intact and
`skills/sw-using-agiledevelopment/SKILL.md` resolves.

3. Fully restart ZCode (not just a new session). After restart, open the
   `/plugins` panel: `sw-agiledevelopment` should appear under the `inline`
   marketplace and be enabled. New sessions will auto-inject the bootstrap.

## Success Message

When complete, tell the user:

```text
sw-agiledevelopment has been added to ZCode. Fully restart ZCode so the
plugin, skills, and SessionStart bootstrap appear, then ask it to use the agile
development workflow.
```

## Troubleshooting

- **Marketplace add fails (network / GitHub access):** ask permission to retry
  with network access, or ask the user to check their connection. Fallback to
  Option B (manual filesystem install).
- **Plugin still does not appear after install:** make sure you fully restarted
  ZCode (Cmd + Q / Quit, then reopen). ZCode only reads `plugins.dirs` from
  `~/.zcode/cli/config.json` at app startup; it does **not** read custom
  marketplace JSON files under `~/.zcode/cli/plugins/marketplaces/`.
- **Skills present but bootstrap not activating:** the SessionStart hook did not
  run. Check the latest `bootstrap.app.startup.plugins.completed` log line for
  `hookCount`; if it is `0`, verify `bash` is available and that the plugin root
  has a `hooks/` directory containing `hooks.json`, `run-hook.cmd`, and
  `session-start`.
- **`session-start` exits with empty output:** confirm `skills/` resolves to the
  real `sw-using-agiledevelopment/` directory. The hook reads
  `${REPO_ROOT}/skills/sw-using-agiledevelopment/SKILL.md`.
- **`@sw-agiledevelopment` is recognized but skills are absent in the current
  session:** this is usually a session-refresh issue. Start a new ZCode session
  after installation. The plugin provides Skills such as
  `sw-requirements-clarification` and `sw-test-driven-dev`; it does not provide
  MCP tools.
