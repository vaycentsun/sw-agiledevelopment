#!/usr/bin/env bash
# Verify the sw-agiledevelopment Android Studio agent bootstrap file.
# Usage: bash scripts/verify-androidstudio.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILED=0

echo "Verifying Android Studio agent bootstrap..."

agent_file="$REPO_ROOT/.androidstudio/sw-agiledevelopment.md"
if [ ! -f "$agent_file" ]; then
    echo "  [FAIL] Missing Android Studio agent file: $agent_file"
    FAILED=1
else
    echo "  [PASS] Android Studio agent file exists"
fi

required_sections=("Skill Registry" "红旗" "TDD")
for section in "${required_sections[@]}"; do
    if grep -q "$section" "$agent_file"; then
        echo "  [PASS] Contains section: $section"
    else
        echo "  [FAIL] Missing section: $section"
        FAILED=1
    fi
done

if grep -q 'sw-using-agiledevelopment' "$agent_file"; then
    echo "  [PASS] References bootstrap skill sw-using-agiledevelopment"
else
    echo "  [FAIL] Does not reference bootstrap skill sw-using-agiledevelopment"
    FAILED=1
fi

if [ "$FAILED" -eq 0 ]; then
    echo ""
    echo "Android Studio agent verification passed!"
    exit 0
else
    echo ""
    echo "Android Studio agent verification failed!"
    exit 1
fi
