# AI Installation Guide for sw-agiledevelopment (DeepSeek Harness)

This guide is written for an AI coding agent. When a user asks you to install
`sw-agiledevelopment` for **DeepSeek Harness (DSH)**, follow these steps and
perform the work yourself when you have permission.

## Goal

Install the 13 `sw-*` skills into the user's DeepSeek Harness skill directory so
they are available in every DSH session, and add a small bootstrap block to the
user-global `AGENTS.md` so each new session loads `sw-using-agiledevelopment`
before responding.

## What this installs

- Skills: `~/.dsh/skills/sw-*` (one entry per `sw-*/SKILL.md` in this repository)
- Bootstrap: a managed `<!-- sw-agiledevelopment:start -->` block in
  `~/.dsh/AGENTS.md`
- Installer state: `~/.dsh/.sw-agiledevelopment/installed-skills`

`$DSH_HOME` overrides `~/.dsh`; the installer uses the same resolution as DSH.

## Skills are not plugins

DeepSeek Harness discovers skills from filesystem roots; `dsh plugin add` installs
code plugins and **cannot** install a skill. The local provider scans, in rank
order:

| Rank | Source | Root |
|------|--------|------|
| 100 | project | `<projectRoot>/.dsh/skills` |
| 200 | project | `<projectRoot>/.agents/skills` |
| 300 | custom | configured `customSkillDirs` |
| 400 | user | `<dshHome>/skills` |
| 500 | user | `<agentsHome>/skills` |

This channel installs into `<dshHome>/skills` (rank 400), so the skills are
available in every project. The repository also ships `.dsh/skills/` for
project-local use when this repository itself is opened in DSH.

DSH watches these roots and hot-reloads the skill catalog; a new skill normally
appears without restarting DSH. The `AGENTS.md` bootstrap is read at the first
step of a session, so start a new session after installing.

## Prerequisites

1. Confirm the user wants the skills installed globally for DeepSeek Harness.
2. Confirm DeepSeek Harness is installed and has created `~/.dsh` (or that
   `$DSH_HOME` points at the intended directory).
3. `bash` and `git` (the installer can clone the repository when it is not
   running from a checkout).
4. `python3` is optional: it is used to update `~/.dsh/AGENTS.md` idempotently.
   Without it, the installer still installs the skills and tells the user to add
   the bootstrap block manually.

If DeepSeek Harness is not installed at all, stop and tell the user DSH must be
installed first.

## Install Steps

### Option A — one command from a checkout (recommended)

```bash
git clone https://github.com/vaycentsun/sw-agiledevelopment.git \
  "$HOME/.dsh/sw-agiledevelopment"
bash "$HOME/.dsh/sw-agiledevelopment/scripts/install-dsh.sh"
```

The installer links every `sw-*/` directory into `~/.dsh/skills/`, adds the
managed bootstrap block to `~/.dsh/AGENTS.md`, and verifies every link resolves
to a readable `SKILL.md`.

### Option B — one command without a checkout

```bash
curl -fsSL https://raw.githubusercontent.com/vaycentsun/sw-agiledevelopment/main/scripts/install-dsh.sh | bash
```

When the script is not running from a checkout it clones the repository into
`~/.dsh/sw-agiledevelopment` first. Re-run the same command to upgrade.

### Option C — manual install

Use this when the user prefers not to run the installer, or wants to install a
single skill.

```bash
mkdir -p "$HOME/.dsh/skills"
for dir in /path/to/sw-agiledevelopment/sw-*/; do
  name="$(basename "$dir")"
  ln -sfn "${dir%/}" "$HOME/.dsh/skills/$name"
done
```

Then add the contents of `.dsh/bootstrap.md` to `~/.dsh/AGENTS.md` inside a
managed block:

```markdown
<!-- sw-agiledevelopment:start -->
## sw-agiledevelopment

The sw-agiledevelopment skill set is installed. At the start of every conversation, before responding or taking action, load `sw-using-agiledevelopment` with the `skill` tool and follow it. It decides which other `sw-*` skills apply (requirements clarification, technical spec, working plan, TDD, systematic debugging, code review, verification).

User instructions always take precedence over the skill set.
<!-- sw-agiledevelopment:end -->
```

### Option D — project-local install

To enable the skills only in one project, put the symlinks in that project's
`.dsh/skills/` instead of the user directory:

```bash
project=/path/to/project
mkdir -p "$project/.dsh/skills"
for dir in /path/to/sw-agiledevelopment/sw-*/; do
  name="$(basename "$dir")"
  ln -sfn "${dir%/}" "$project/.dsh/skills/$name"
done
```

Add the same bootstrap block to the project's `AGENTS.md` (or tell the user to
invoke `/sw-using-agiledevelopment` at the start of each session).

## Verify installation

1. Run the repository verifier from the checkout:

```bash
bash /path/to/sw-agiledevelopment/scripts/verify-dsh.sh
```

2. Confirm the installed links and bootstrap:

```bash
ls -l "$HOME/.dsh/skills" | grep ' sw-'
test -f "$HOME/.dsh/skills/sw-using-agiledevelopment/SKILL.md" && echo "skill OK"
grep -n "sw-agiledevelopment:start" "$HOME/.dsh/AGENTS.md"
```

3. Start a new DeepSeek Harness session and ask:

```text
List your available skills, then use the sw-agiledevelopment workflow.
```

The `sw-*` skills should appear in the session's available-skills catalog. The
agent should load `sw-using-agiledevelopment` with the native `skill` tool before
responding.

4. Optional: invoke a skill directly from the DSH prompt:

```text
/sw-using-agiledevelopment
```

## Upgrading

- Checkout install: `git -C ~/.dsh/sw-agiledevelopment pull --ff-only` and re-run
  `bash ~/.dsh/sw-agiledevelopment/scripts/install-dsh.sh`.
- Clone install (Option B): re-run the same `curl` command.
- `--copy` install: re-run the installer; it replaces the copied directories.

The installer rewrites the managed `AGENTS.md` block in place. User content
outside the block is preserved.

## Uninstalling

```bash
bash "$HOME/.dsh/sw-agiledevelopment/scripts/install-dsh.sh" --uninstall
```

This removes the managed skill entries and the `AGENTS.md` block. It leaves the
source checkout in `~/.dsh/sw-agiledevelopment` untouched; delete it manually if
the user no longer wants it.

## Troubleshooting

- **`dsh plugin add` does not install the skills:** expected. Skills are
  filesystem-discovered, not plugins. Follow this guide instead.
- **Skills do not appear in a session:** confirm the directory is
  `$DSH_HOME/skills` (default `~/.dsh/skills`), each entry is a symlink or
  directory containing `SKILL.md`, and the link resolves. Start a new session.
  A project-local `.dsh/skills` (rank 100) can also shadow a user skill.
- **Bootstrap does not activate:** confirm `~/.dsh/AGENTS.md` contains the
  `sw-agiledevelopment:start` block, then start a new session. The block is
  read at the first step of a session; an existing session keeps its baseline.
- **The desktop app uses a different home:** if `DSH_HOME` is set in a shell but
  the DSH desktop app was launched outside that shell, the app may still read
  `~/.dsh`. Install into the default `~/.dsh` (omit `DSH_HOME`) or set the
  variable in the environment that launches the app.
- **`AGENTS.md` already has content:** the installer appends the managed block
  and only rewrites that block on later runs. Other content is preserved. If the
  user wants no global edit, use `--no-bootstrap` and invoke
  `/sw-using-agiledevelopment` instead.
- **Windows:** `ln -s` needs Developer Mode or an elevated shell. Use Git Bash
  with symlink support, or install with `--copy`:

  ```bash
  bash scripts/install-dsh.sh --copy
  ```

  A PowerShell junction is also fine:
  `New-Item -ItemType Junction -Path "$HOME\.dsh\skills\sw-code-review" -Target "C:\path\to\sw-agiledevelopment\sw-code-review"`.
- **Existing skill with the same name:** the installer refuses to overwrite a
  real directory or file. Move it away, or re-run with `--force` to back it up
  under `~/.dsh/.sw-agiledevelopment/backup/`.
- **A disconnected `DSH_HOME`:** set `DSH_HOME` explicitly when installing and
  when launching DSH; both must resolve to the same directory.

## Success Message

When complete, tell the user:

```text
sw-agiledevelopment is installed for DeepSeek Harness. Start a new DSH session
so the skills and the AGENTS.md bootstrap are picked up, then ask it to use the
agile development workflow.
```
