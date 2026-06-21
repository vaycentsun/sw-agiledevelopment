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

The plugin manifest lives at `plugin/plugin.json` and declares
`"skills": "skills"`, pointing at the repository-root `skills/` directory (a set
of symlinks to the real `sw-*/` source directories). A `SessionStart` hook in
`plugin/hooks/` reads `sw-using-agiledevelopment/SKILL.md` and injects it
into each new session — this is what makes the agile workflow reliably activate.

## Prerequisites

1. Confirm the user wants this installed in their ZCode environment.
2. Confirm a ZCode installation is present. Look for one of:
   - The `zcode` CLI on `PATH` (`zcode --version`), or
   - The ZCode config directory at `~/.zcode/cli/plugins/`.
3. Confirm `git` and `bash`/`zsh` are available (needed to clone and to run the
   SessionStart hook on Unix; on Windows the polyglot `run-hook.cmd` wrapper
   locates bash automatically).

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

This mirrors how the official `zcode-plugins-official` plugins are laid out on
disk under `~/.zcode/cli/plugins/`. Use it when there is no `zcode` CLI or the
marketplace command is unavailable.

```bash
# 1. Clone (or update) the source repository to a stable location.
git clone https://github.com/vaycentsun/sw-agiledevelopment.git \
  "$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment"

# 2. Register the plugin in the user's marketplace index.
MARKETPLACE_FILE="$HOME/.zcode/cli/plugins/marketplaces/sw-agiledevelopment/marketplace.json"
mkdir -p "$(dirname "$MARKETPLACE_FILE")"
```

Then write `$MARKETPLACE_FILE` with the following content (replace `<VERSION>`
with the value from the cloned repo's `VERSION` file, e.g. `1.3.2`, and
`<CACHE_PATH>` with the absolute clone path from step 1):

```json
{
  "name": "sw-agiledevelopment",
  "plugins": [
    {
      "cachePath": "<CACHE_PATH>",
      "name": "sw-agiledevelopment",
      "source": "filesystem",
      "version": "<VERSION>"
    }
  ],
  "version": 1
}
```

> Note: the plugin is consumed directly from the clone path. The repository root
> **is** the plugin root (it contains `plugin/plugin.json`). Do not point
> `cachePath` at `plugin/` — point it at the repository root.

## Verify installation

1. Confirm the plugin manifest is reachable:

```bash
cat "$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment/plugin/plugin.json"
```

2. Confirm the SessionStart hook runs and emits valid JSON context:

```bash
CLAUDE_PLUGIN_ROOT="$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment/plugin" \
  bash "$HOME/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment/plugin/hooks/session-start" \
  | python3 -m json.tool > /dev/null && echo "hook OK"
```

This should print `hook OK`. If it prints nothing or errors, the skills path or
symlinks are wrong — re-check that the clone is intact and `skills/sw-using-agiledevelopment/SKILL.md`
resolves.

3. Start a new ZCode session and ask it to use the agile development workflow.
   The bootstrap content (`sw-using-agiledevelopment`) should already be active.

## Success Message

When complete, tell the user:

```text
sw-agiledevelopment has been added to ZCode. Start a new ZCode session so the
skills and SessionStart bootstrap appear, then ask it to use the agile
development workflow.
```

## Troubleshooting

- **Marketplace add fails (network / GitHub access):** ask permission to retry
  with network access, or ask the user to check their connection. Fallback to
  Option B (manual filesystem install).
- **Skills present in the plugin but bootstrap not activating:** the SessionStart
  hook did not run. Verify `bash` is available (on Windows, that Git Bash is
  installed) and that `CLAUDE_PLUGIN_ROOT`/`CURSOR_PLUGIN_ROOT` is set by the
  host. Then start a fresh session.
- **`session-start` exits with empty output:** confirm `skills/` (the symlink
  directory at the repo root) resolves to the real `sw-using-agiledevelopment/`
  directory. The hook reads `${REPO_ROOT}/skills/sw-using-agiledevelopment/SKILL.md`.
- **ZCode still does not see the plugin:** some ZCode builds must be restarted
  after a marketplace is added. Ask the user to restart ZCode, then open the
  plugin panel again.
- **`@sw-agiledevelopment` is recognized but skills are absent in the current
  session:** this is usually a session-refresh issue. Start a new ZCode session
  after installation. The plugin provides Skills such as
  `sw-requirements-clarification` and `sw-test-driven-dev`; it does not provide
  MCP tools.
