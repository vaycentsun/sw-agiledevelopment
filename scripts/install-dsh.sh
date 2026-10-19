#!/usr/bin/env bash
#
# Install the sw-agiledevelopment skills into DeepSeek Harness (DSH).
#
# Usage:
#   bash scripts/install-dsh.sh [options]
#
# What it does:
#   1. Finds this repository (or clones it into $DSH_HOME/sw-agiledevelopment).
#   2. Links every sw-*/ directory into $DSH_HOME/skills/ so DSH discovers it
#      through its native filesystem skill provider.
#   3. Appends (or refreshes) a managed sw-agiledevelopment block in
#      $DSH_HOME/AGENTS.md so every new session loads the workflow bootstrap.
#   4. Verifies that every installed skill resolves to a readable SKILL.md.
#
# DSH watches <dshHome>/skills and hot-reloads the catalog; no restart is
# normally required. Start a new session to pick up the AGENTS.md bootstrap.
#
# Options:
#   --source <dir>   Install from a local checkout instead of cloning.
#   --copy           Copy skill directories instead of symlinking them.
#   --no-bootstrap   Do not touch $DSH_HOME/AGENTS.md.
#   --force          Back up and replace an existing non-symlink skill entry.
#   --uninstall      Remove the managed skills and AGENTS.md block.
#   -h, --help       Show this help.
#
set -euo pipefail

REPO_URL="https://github.com/vaycentsun/sw-agiledevelopment.git"
DSH_HOME="${DSH_HOME:-$HOME/.dsh}"
SKILLS_DIR="$DSH_HOME/skills"
AGENTS_FILE="$DSH_HOME/AGENTS.md"
STATE_DIR="$DSH_HOME/.sw-agiledevelopment"
MANIFEST="$STATE_DIR/installed-skills"
CLONE_DIR="$DSH_HOME/sw-agiledevelopment"
START_MARKER="<!-- sw-agiledevelopment:start -->"
END_MARKER="<!-- sw-agiledevelopment:end -->"

MODE="install"
SOURCE_DIR=""
NO_BOOTSTRAP=0
COPY_MODE=0
FORCE=0

usage() {
  cat <<'EOF'
Install the sw-agiledevelopment skills into DeepSeek Harness (DSH).

Usage:
  bash scripts/install-dsh.sh [options]

What it does:
  1. Finds this repository (or clones it into $DSH_HOME/sw-agiledevelopment).
  2. Links every sw-*/ directory into $DSH_HOME/skills/ so DSH discovers it
     through its native filesystem skill provider.
  3. Appends (or refreshes) a managed sw-agiledevelopment block in
     $DSH_HOME/AGENTS.md so every new session loads the workflow bootstrap.
  4. Verifies that every installed skill resolves to a readable SKILL.md.

DSH watches <dshHome>/skills and hot-reloads the catalog; no restart is
normally required. Start a new session to pick up the AGENTS.md bootstrap.

Options:
  --source <dir>   Install from a local checkout instead of cloning.
  --copy           Copy skill directories instead of symlinking them.
  --no-bootstrap   Do not touch $DSH_HOME/AGENTS.md.
  --force          Back up and replace an existing non-symlink skill entry.
  --uninstall      Remove the managed skills and AGENTS.md block.
  -h, --help       Show this help.
EOF
}

info() {
  printf '%s\n' "$*"
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --source)
      [ "$#" -ge 2 ] || die "--source requires a directory"
      SOURCE_DIR="$2"
      shift 2
      ;;
    --copy)
      COPY_MODE=1
      shift
      ;;
    --no-bootstrap)
      NO_BOOTSTRAP=1
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --uninstall)
      MODE="uninstall"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown option: $1 (try --help)"
      ;;
  esac
done

# Return the repository root when this script is running from a checkout.
local_source_root() {
  local script_path="${BASH_SOURCE[0]:-}"
  [ -n "$script_path" ] || return 1
  [ -f "$script_path" ] || return 1
  local script_dir candidate
  script_dir="$(cd "$(dirname "$script_path")" && pwd)"
  candidate="$(dirname "$script_dir")"
  [ -f "$candidate/sw-using-agiledevelopment/SKILL.md" ] || return 1
  printf '%s\n' "$candidate"
}

# Resolve SOURCE_DIR for install and best-effort for uninstall.
if [ -n "$SOURCE_DIR" ]; then
  SOURCE_DIR="$(cd "$SOURCE_DIR" 2>/dev/null && pwd)" || die "source directory not found: $SOURCE_DIR"
elif LOCAL_SOURCE="$(local_source_root)"; then
  SOURCE_DIR="$LOCAL_SOURCE"
fi

# Rewrite (or append) the managed bootstrap block in $DSH_HOME/AGENTS.md.
install_bootstrap_block() {
  local block_file="$1"
  if ! command -v python3 >/dev/null 2>&1; then
    info "WARNING: python3 not found; skipped the AGENTS.md bootstrap block."
    info "         Add the contents of $block_file to $AGENTS_FILE manually."
    return 0
  fi
  python3 - "$AGENTS_FILE" "$block_file" "$START_MARKER" "$END_MARKER" <<'PY'
import os
import re
import sys

path, block_path, start, end = sys.argv[1:5]
with open(block_path, "r", encoding="utf-8") as handle:
    block = handle.read().strip()
managed = f"{start}\n{block}\n{end}"
text = ""
if os.path.exists(path):
    with open(path, "r", encoding="utf-8") as handle:
        text = handle.read()

if start in text and end in text:
    before, rest = text.split(start, 1)
    _, after = rest.split(end, 1)
    new_text = before.rstrip("\n") + "\n\n" + managed + "\n" + after.lstrip("\n")
else:
    new_text = text.rstrip("\n")
    if new_text:
        new_text += "\n\n"
    new_text += managed + "\n"

new_text = re.sub(r"\n{3,}", "\n\n", new_text).rstrip("\n") + "\n"
os.makedirs(os.path.dirname(path), exist_ok=True)
with open(path, "w", encoding="utf-8") as handle:
    handle.write(new_text)
PY
  info "Updated managed bootstrap block in $AGENTS_FILE"
}

remove_bootstrap_block() {
  [ -f "$AGENTS_FILE" ] || return 0
  if ! command -v python3 >/dev/null 2>&1; then
    info "WARNING: python3 not found; remove the sw-agiledevelopment block from $AGENTS_FILE manually."
    return 0
  fi
  python3 - "$AGENTS_FILE" "$START_MARKER" "$END_MARKER" <<'PY'
import os
import re
import sys

path, start, end = sys.argv[1:4]
with open(path, "r", encoding="utf-8") as handle:
    text = handle.read()
if start not in text or end not in text:
    sys.exit(0)

before, rest = text.split(start, 1)
_, after = rest.split(end, 1)
new_text = before.rstrip("\n") + ("\n\n" if before.strip() and after.strip() else "") + after.lstrip("\n")
new_text = re.sub(r"\n{3,}", "\n\n", new_text).strip()
if new_text:
    with open(path, "w", encoding="utf-8") as handle:
        handle.write(new_text + "\n")
else:
    os.remove(path)
PY
  info "Removed managed bootstrap block from $AGENTS_FILE"
}

if [ "$MODE" = "uninstall" ]; then
  removed=0
  if [ -f "$MANIFEST" ]; then
    first=1
    while IFS= read -r name; do
      [ -n "$name" ] || continue
      if [ "$first" -eq 1 ]; then
        first=0
        continue
      fi
      dest="$SKILLS_DIR/$name"
      if [ -L "$dest" ] || [ -e "$dest" ]; then
        rm -rf "$dest"
        info "Removed $dest"
        removed=$((removed + 1))
      fi
    done < "$MANIFEST"
  elif [ -n "$SOURCE_DIR" ] && [ -d "$SKILLS_DIR" ]; then
    for dest in "$SKILLS_DIR"/sw-*; do
      [ -L "$dest" ] || continue
      target="$(readlink "$dest")"
      case "$target" in
        "$SOURCE_DIR"/*)
          rm -f "$dest"
          info "Removed $dest"
          removed=$((removed + 1))
          ;;
      esac
    done
  fi

  remove_bootstrap_block
  rm -rf "$STATE_DIR"
  info ""
  info "sw-agiledevelopment removed from DeepSeek Harness ($removed skill entries)."
  info "The source checkout at ${SOURCE_DIR:-$CLONE_DIR} was left untouched."
  exit 0
fi

# Install mode: clone when there is no local checkout to link to.
if [ -z "$SOURCE_DIR" ]; then
  command -v git >/dev/null 2>&1 || die "git is required to clone $REPO_URL"
  if [ -d "$CLONE_DIR/.git" ]; then
    info "Updating $CLONE_DIR"
    git -C "$CLONE_DIR" pull --ff-only
  elif [ -e "$CLONE_DIR" ]; then
    die "$CLONE_DIR exists but is not a git checkout; move it away and retry, or pass --source"
  else
    info "Cloning $REPO_URL into $CLONE_DIR"
    git clone "$REPO_URL" "$CLONE_DIR"
  fi
  SOURCE_DIR="$CLONE_DIR"
fi

[ -f "$SOURCE_DIR/sw-using-agiledevelopment/SKILL.md" ] \
  || die "$SOURCE_DIR does not look like a sw-agiledevelopment checkout"
[ -d "$SOURCE_DIR/.dsh" ] \
  || die "$SOURCE_DIR is missing .dsh/ (the DeepSeek Harness channel)"

VERSION="$(tr -d '[:space:]' < "$SOURCE_DIR/VERSION" 2>/dev/null || printf 'unknown')"

info "Installing sw-agiledevelopment ${VERSION} for DeepSeek Harness"
info "  source:     $SOURCE_DIR"
info "  skills:     $SKILLS_DIR"
info "  bootstrap:  $AGENTS_FILE"

mkdir -p "$SKILLS_DIR" "$STATE_DIR"
TMP_MANIFEST="$MANIFEST.tmp"
: > "$TMP_MANIFEST"
printf '%s\n' "$SOURCE_DIR" >> "$TMP_MANIFEST"

installed=0
for dir in "$SOURCE_DIR"/sw-*/; do
  [ -d "$dir" ] || continue
  [ -f "$dir/SKILL.md" ] || continue
  name="$(basename "$dir")"
  target="${dir%/}"
  dest="$SKILLS_DIR/$name"

  if [ -L "$dest" ]; then
    rm -f "$dest"
  elif [ -e "$dest" ]; then
    if [ "$FORCE" -eq 1 ]; then
      backup_dir="$STATE_DIR/backup/$(date +%Y%m%d-%H%M%S)-$$"
      mkdir -p "$backup_dir"
      mv "$dest" "$backup_dir/$name"
      info "Backed up existing $dest to $backup_dir/$name"
    else
      die "refusing to overwrite $dest; move it away or re-run with --force"
    fi
  fi

  if [ "$COPY_MODE" -eq 1 ]; then
    cp -R "$target" "$dest"
  else
    ln -s "$target" "$dest"
  fi
  printf '%s\n' "$name" >> "$TMP_MANIFEST"
  installed=$((installed + 1))
done

[ "$installed" -gt 0 ] || die "no sw-*/SKILL.md entries found under $SOURCE_DIR"
mv "$TMP_MANIFEST" "$MANIFEST"

if [ "$NO_BOOTSTRAP" -eq 0 ] && [ -f "$SOURCE_DIR/.dsh/bootstrap.md" ]; then
  install_bootstrap_block "$SOURCE_DIR/.dsh/bootstrap.md"
elif [ "$NO_BOOTSTRAP" -eq 1 ]; then
  info "Skipped the AGENTS.md bootstrap block (--no-bootstrap)"
else
  info "WARNING: $SOURCE_DIR/.dsh/bootstrap.md is missing; skipped the AGENTS.md bootstrap block."
fi

# Verify every installed entry resolves to a readable SKILL.md.
failed=0
first=1
while IFS= read -r name; do
  [ -n "$name" ] || continue
  if [ "$first" -eq 1 ]; then
    first=0
    continue
  fi
  if [ ! -f "$SKILLS_DIR/$name/SKILL.md" ]; then
    info "  [FAIL] $SKILLS_DIR/$name/SKILL.md is not readable"
    failed=1
  fi
done < "$MANIFEST"
[ "$failed" -eq 0 ] || die "installation verification failed"

info ""
info "Installed $installed skills under $SKILLS_DIR."
info "DeepSeek Harness watches that directory, so new sessions pick them up without a restart."
info "Start a new DSH session and ask: \"Use the sw-agiledevelopment workflow for this task.\""
info "Or invoke /sw-using-agiledevelopment directly."
