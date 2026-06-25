#!/usr/bin/env bash
# Verify the sw-agiledevelopment Codex plugin structure.
# Usage: bash scripts/verify-codex.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILED=0

echo "Verifying Codex plugin..."

manifest="$REPO_ROOT/.codex-plugin/plugin.json"
if [ ! -f "$manifest" ]; then
    echo "  [FAIL] Missing Codex plugin manifest: $manifest"
    FAILED=1
else
    echo "  [PASS] Codex plugin manifest exists"
fi

if command -v python3 >/dev/null 2>&1; then
    if python3 -m json.tool "$manifest" >/dev/null 2>&1; then
        echo "  [PASS] Codex plugin manifest is valid JSON"
    else
        echo "  [FAIL] Codex plugin manifest is not valid JSON"
        FAILED=1
    fi
else
    echo "  [SKIP] python3 not available, skipping JSON validation"
fi

if grep -q '"skills"' "$manifest" 2>/dev/null; then
    echo "  [PASS] Codex manifest declares a skills path"
else
    echo "  [FAIL] Codex manifest does not declare a skills path"
    FAILED=1
fi

if [ -d "$REPO_ROOT/skills" ]; then
    echo "  [PASS] skills/ directory exists"
else
    echo "  [FAIL] skills/ directory missing"
    FAILED=1
fi

skill_count=$(find "$REPO_ROOT/skills" -maxdepth 1 -type l | wc -l | tr -d ' ')
if [ "$skill_count" -gt 0 ]; then
    echo "  [PASS] skills/ directory contains $skill_count symlinks"
else
    echo "  [FAIL] skills/ directory contains no skill symlinks"
    FAILED=1
fi

if [ "$FAILED" -eq 0 ]; then
    echo ""
    echo "Codex plugin verification passed!"
    exit 0
else
    echo ""
    echo "Codex plugin verification failed!"
    exit 1
fi
