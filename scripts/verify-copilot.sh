#!/usr/bin/env bash
# Verify the sw-agiledevelopment Copilot instructions file.
# Usage: bash scripts/verify-copilot.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILED=0

echo "Verifying Copilot instructions..."

instructions="$REPO_ROOT/.github/copilot-instructions.md"
if [ ! -f "$instructions" ]; then
    echo "  [FAIL] Missing Copilot instructions: $instructions"
    FAILED=1
else
    echo "  [PASS] Copilot instructions file exists"
fi

required_sections=("指令优先级" "红旗" "常见借口")
for section in "${required_sections[@]}"; do
    if grep -q "$section" "$instructions"; then
        echo "  [PASS] Contains section: $section"
    else
        echo "  [FAIL] Missing section: $section"
        FAILED=1
    fi
done

if grep -q 'sw-using-agiledevelopment' "$instructions"; then
    echo "  [PASS] References bootstrap skill sw-using-agiledevelopment"
else
    echo "  [WARN] Does not explicitly reference bootstrap skill sw-using-agiledevelopment (file itself may serve as bootstrap)"
fi

if [ "$FAILED" -eq 0 ]; then
    echo ""
    echo "Copilot instructions verification passed!"
    exit 0
else
    echo ""
    echo "Copilot instructions verification failed!"
    exit 1
fi
