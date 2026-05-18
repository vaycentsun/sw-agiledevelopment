# AI Installation Guide for sw-agiledevelopment

This guide is written for an AI coding agent. When a user asks you to install
`sw-agiledevelopment` for Codex, follow these steps and perform the work
yourself when you have permission.

## Goal

Add the `sw-agiledevelopment` Codex plugin marketplace and install the
`sw-agiledevelopment` plugin from it.

## What this installs

- Marketplace repository: `vaycentsun/sw-agiledevelopment`
- Marketplace path: `.agents/plugins`
- Marketplace ref: `main`
- Plugin name: `sw-agiledevelopment`

## Prerequisites

1. Confirm the user wants this installed in their Codex environment.
2. Confirm the `codex` CLI is available:

```bash
codex --version
```

If `codex` is missing, stop and tell the user Codex CLI must be installed first.

## Install Steps

### 1. Add the marketplace

Run:

```bash
codex plugin marketplace add vaycentsun/sw-agiledevelopment --ref main --sparse .agents/plugins
```

If the marketplace already exists, do not add a duplicate. Continue to the
plugin installation step.

### 2. Install the plugin

First try the Codex CLI plugin install command:

```bash
codex plugin install sw-agiledevelopment
```

If the CLI reports that direct plugin installation is not available, open the
Codex plugin interface instead:

```bash
codex plugin
```

Then install `sw-agiledevelopment` from the `sw-agiledevelopment` marketplace.
If you are running in an environment without interactive UI access, tell the
user to open `/plugins` in Codex and install `sw-agiledevelopment` from the
`sw-agiledevelopment` marketplace.

### 3. Verify installation

After installation, verify that Codex can see the plugin or marketplace:

```bash
codex plugin marketplace list
```

If available, also list installed plugins:

```bash
codex plugin list
```

Look for:

- Marketplace: `sw-agiledevelopment` or `vaycentsun/sw-agiledevelopment`
- Plugin: `sw-agiledevelopment`

## Success Message

When complete, tell the user:

```text
sw-agiledevelopment has been added to Codex. Start a new Codex session and ask
it to use the agile development workflow.
```

## Troubleshooting

If marketplace add fails because of network or GitHub access, ask for permission
to retry with network access or ask the user to check their connection.

If plugin installation fails because the marketplace is not visible, re-run:

```bash
codex plugin marketplace add vaycentsun/sw-agiledevelopment --ref main --sparse .agents/plugins
```

If Codex requires a restart after marketplace installation, ask the user to
restart Codex, then install `sw-agiledevelopment` from `/plugins`.
