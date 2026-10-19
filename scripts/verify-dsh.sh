#!/usr/bin/env bash
# Verify the sw-agiledevelopment DeepSeek Harness (DSH) channel.
# Usage: bash scripts/verify-dsh.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILED=0

pass() {
  printf '  [PASS] %s\n' "$1"
}

fail() {
  printf '  [FAIL] %s\n' "$1"
  FAILED=1
}

echo "Verifying DeepSeek Harness (DSH) channel..."

# Channel documentation and bootstrap source.
if [ -f "$REPO_ROOT/.dsh/INSTALL.md" ]; then
  pass ".dsh/INSTALL.md exists"
else
  fail "missing .dsh/INSTALL.md"
fi

if [ -f "$REPO_ROOT/.dsh/bootstrap.md" ]; then
  pass ".dsh/bootstrap.md exists"
  if grep -q 'sw-using-agiledevelopment' "$REPO_ROOT/.dsh/bootstrap.md"; then
    pass ".dsh/bootstrap.md references sw-using-agiledevelopment"
  else
    fail ".dsh/bootstrap.md does not reference sw-using-agiledevelopment"
  fi
else
  fail "missing .dsh/bootstrap.md"
fi

# The project-local skill root DSH discovers at <projectRoot>/.dsh/skills.
if [ -d "$REPO_ROOT/.dsh/skills" ]; then
  pass ".dsh/skills exists"
else
  fail "missing .dsh/skills"
fi

skill_count=0
for dir in "$REPO_ROOT"/sw-*/; do
  [ -d "$dir" ] || continue
  [ -f "$dir/SKILL.md" ] || continue
  name="$(basename "$dir")"
  skill_count=$((skill_count + 1))

  link="$REPO_ROOT/.dsh/skills/$name"
  if [ ! -L "$link" ]; then
    fail ".dsh/skills/$name is not a symlink"
    continue
  fi
  if [ ! -f "$link/SKILL.md" ]; then
    fail ".dsh/skills/$name does not resolve to a readable SKILL.md"
    continue
  fi

  if head -1 "$dir/SKILL.md" | grep -q '^---$' \
    && grep -q "^name: $name$" "$dir/SKILL.md" \
    && grep -q '^description:' "$dir/SKILL.md"; then
    pass "$name has valid frontmatter and a DSH symlink"
  else
    fail "$name has invalid frontmatter (need ---, name: $name, description:)"
  fi
done

if [ "$skill_count" -gt 0 ]; then
  actual_links=$(find "$REPO_ROOT/.dsh/skills" -maxdepth 1 -type l | wc -l | tr -d ' ')
  if [ "$actual_links" -eq "$skill_count" ]; then
    pass ".dsh/skills contains exactly $skill_count skill symlinks"
  else
    fail ".dsh/skills contains $actual_links symlinks, expected $skill_count"
  fi
else
  fail "no sw-*/SKILL.md skills found"
fi

# Installer and tool mapping.
installer="$REPO_ROOT/scripts/install-dsh.sh"
if [ -f "$installer" ]; then
  pass "scripts/install-dsh.sh exists"
  if [ -x "$installer" ]; then
    pass "scripts/install-dsh.sh is executable"
  else
    fail "scripts/install-dsh.sh is not executable"
  fi
  if bash -n "$installer"; then
    pass "scripts/install-dsh.sh has valid bash syntax"
  else
    fail "scripts/install-dsh.sh has invalid bash syntax"
  fi
  if grep -q 'sw-using-agiledevelopment' "$installer" \
    && grep -q 'AGENTS.md' "$installer" \
    && grep -q 'skills' "$installer"; then
    pass "scripts/install-dsh.sh installs skills and the AGENTS.md bootstrap"
  else
    fail "scripts/install-dsh.sh is missing skills or AGENTS.md install logic"
  fi
else
  fail "missing scripts/install-dsh.sh"
fi

dsh_tools="$REPO_ROOT/sw-using-agiledevelopment/references/dsh-tools.md"
if [ -f "$dsh_tools" ]; then
  pass "sw-using-agiledevelopment/references/dsh-tools.md exists"
  for needle in '`skill`' '`subagent`' '`todo_write`'; do
    if grep -q "$needle" "$dsh_tools"; then
      pass "dsh-tools.md documents $needle"
    else
      fail "dsh-tools.md does not document $needle"
    fi
  done
else
  fail "missing sw-using-agiledevelopment/references/dsh-tools.md"
fi

if grep -q 'DeepSeek Harness' "$REPO_ROOT/sw-using-agiledevelopment/SKILL.md" \
  && grep -q 'dsh-tools.md' "$REPO_ROOT/sw-using-agiledevelopment/SKILL.md"; then
  pass "sw-using-agiledevelopment/SKILL.md documents the DSH mapping"
else
  fail "sw-using-agiledevelopment/SKILL.md does not document the DSH mapping"
fi

if [ "$FAILED" -eq 0 ]; then
  echo ""
  echo "DeepSeek Harness channel verification passed!"
  exit 0
else
  echo ""
  echo "DeepSeek Harness channel verification failed!"
  exit 1
fi
