#!/usr/bin/env bash
# Verify the sw-agiledevelopment ZCode plugin structure.
# Usage: bash scripts/verify-zcode.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILED=0

echo "Verifying ZCode plugin..."

manifest="$REPO_ROOT/.zcode-plugin/plugin.json"
if [ ! -f "$manifest" ]; then
    echo "  [FAIL] Missing ZCode plugin manifest: $manifest"
    FAILED=1
else
    echo "  [PASS] ZCode plugin manifest exists"
fi

hooks_json="$REPO_ROOT/.zcode-plugin/hooks/hooks.json"
if [ ! -f "$hooks_json" ]; then
    echo "  [FAIL] Missing hooks.json: $hooks_json"
    FAILED=1
else
    echo "  [PASS] hooks.json exists"
fi

session_start="$REPO_ROOT/.zcode-plugin/hooks/session-start"
if [ ! -f "$session_start" ]; then
    echo "  [FAIL] Missing session-start hook: $session_start"
    FAILED=1
else
    echo "  [PASS] session-start hook exists"
fi

if [ -x "$session_start" ]; then
    echo "  [PASS] session-start hook is executable"
else
    echo "  [FAIL] session-start hook is not executable"
    FAILED=1
fi

if [ -d "$REPO_ROOT/skills" ]; then
    echo "  [PASS] skills/ directory exists"
else
    echo "  [FAIL] skills/ directory missing"
    FAILED=1
fi

for skill_dir in "$REPO_ROOT"/sw-*/; do
    skill_name=$(basename "$skill_dir")
    symlink="$REPO_ROOT/skills/$skill_name"
    if [ ! -L "$symlink" ]; then
        echo "  [FAIL] skills/$skill_name is not a symlink"
        FAILED=1
    fi
done

if command -v bash >/dev/null 2>&1 && command -v python3 >/dev/null 2>&1; then
    if "$session_start" | python3 -m json.tool >/dev/null 2>&1; then
        echo "  [PASS] session-start hook emits valid JSON"
    else
        echo "  [FAIL] session-start hook does not emit valid JSON"
        FAILED=1
    fi
else
    echo "  [SKIP] bash/python3 not available, skipping hook JSON validation"
fi

if [ "$FAILED" -eq 0 ]; then
    echo ""
    echo "ZCode plugin verification passed!"
    exit 0
else
    echo ""
    echo "ZCode plugin verification failed!"
    exit 1
fi
