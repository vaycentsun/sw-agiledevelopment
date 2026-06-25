#!/usr/bin/env bash
# Verify the sw-agiledevelopment OpenCode plugin installation.
# Usage: bash scripts/verify-opencode.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILED=0

echo "Verifying OpenCode plugin..."

plugin_file="$REPO_ROOT/.opencode/plugins/sw-agiledevelopment.js"
if [ ! -f "$plugin_file" ]; then
    echo "  [FAIL] Missing plugin file: $plugin_file"
    FAILED=1
else
    echo "  [PASS] Plugin file exists"
fi

if [ ! -f "$REPO_ROOT/package.json" ]; then
    echo "  [FAIL] Missing package.json"
    FAILED=1
else
    echo "  [PASS] package.json exists"
fi

main_field=$(grep '"main"' "$REPO_ROOT/package.json" 2>/dev/null || true)
if echo "$main_field" | grep -q 'sw-agiledevelopment.js'; then
    echo "  [PASS] package.json main points to OpenCode plugin"
else
    echo "  [FAIL] package.json main does not point to OpenCode plugin"
    echo "         $main_field"
    FAILED=1
fi

if command -v node >/dev/null 2>&1; then
    if node -c "$plugin_file" >/dev/null 2>&1; then
        echo "  [PASS] Plugin JavaScript syntax is valid"
    else
        echo "  [FAIL] Plugin JavaScript has syntax errors"
        FAILED=1
    fi
else
    echo "  [SKIP] node not available, skipping JS syntax check"
fi

if [ "$FAILED" -eq 0 ]; then
    echo ""
    echo "OpenCode plugin verification passed!"
    exit 0
else
    echo ""
    echo "OpenCode plugin verification failed!"
    exit 1
fi
