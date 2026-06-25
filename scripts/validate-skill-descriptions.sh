#!/usr/bin/env bash
# Validate SKILL.md description fields against Claude Search Optimization (CSO) rules.
# Usage: bash scripts/validate-skill-descriptions.sh
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FAILED=0
WARNED=0

# Common trigger keywords: symptoms, errors, tools, or situations that Agent might search for.
TRIGGER_KEYWORDS=(
    "feature" "requirements" "requirement" "bug" "bugs" "test" "tests" "testing"
    "failure" "failures" "failing" "error" "errors" "review" "reviews" "reviewing"
    "verify" "verification" "validating" "implement" "implementation" "implementing"
    "spec" "specs" "specification" "plan" "plans" "planning" "skill" "skills"
    "code" "coding" "task" "tasks" "branch" "branches" "merge" "merging"
    "debug" "debugging" "fix" "fixing" "clarify" "clarifying" "design" "designing"
    "deploy" "deploying" "release" "releasing" "race" "racing" "flaky" "hang"
    "hanging" "timeout" "zombie" "pollution" "refactor" "refactoring" "complete"
    "finishing" "discarding" "keeping" "pr" "pull request" "commit" "push"
    "unexpected" "inconsistent" "behavior" "behaviour" "performance"
)

# Workflow-summary phrases that should not appear in a description.
WORKFLOW_PHRASES=(
    " dispatches "
    " guides "
    " enforces "
    " establishes "
    " breaks down "
    " transforms "
    " validates "
    " defines "
    " provides "
    " executes "
    " creates "
    " writes "
    "workflow"
    "process"
    "steps"
    " - "
)

echo "Validating skill descriptions (CSO)..."

for skill_file in "$REPO_ROOT"/sw-*/SKILL.md; do
    if [ ! -f "$skill_file" ]; then
        continue
    fi

    skill_name=$(basename "$(dirname "$skill_file")")
    desc=$(grep '^description:' "$skill_file" | head -1 | sed 's/^description:[[:space:]]*//; s/^"//; s/"$//')

    if [ -z "$desc" ]; then
        echo "  [FAIL] $skill_name: Missing description field"
        FAILED=1
        continue
    fi

    # 1. Must start with "Use when"
    if [[ ! "$desc" =~ ^Use[[:space:]]when ]]; then
        echo "  [FAIL] $skill_name: Description must start with 'Use when'"
        echo "         $desc"
        FAILED=1
    fi

    # 2. Length checks
    len=${#desc}
    if [ "$len" -gt 500 ]; then
        echo "  [FAIL] $skill_name: Description is $len characters (max 500)"
        echo "         $desc"
        FAILED=1
    elif [ "$len" -gt 200 ]; then
        echo "  [WARN] $skill_name: Description is $len characters (ideal < 200)"
        echo "         $desc"
        WARNED=1
    fi

    # 3. Must use third person (no first-person pronouns)
    if echo "$desc" | grep -qiE '\b(I|we|my|our|me|us)\b'; then
        echo "  [FAIL] $skill_name: Description uses first-person pronoun"
        echo "         $desc"
        FAILED=1
    fi

    # 4. Must not summarize workflow
    for phrase in "${WORKFLOW_PHRASES[@]}"; do
        if echo "$desc" | grep -qiF "$phrase"; then
            echo "  [FAIL] $skill_name: Description contains workflow summary phrase '$phrase'"
            echo "         $desc"
            FAILED=1
            break
        fi
    done

    # 5. Should contain at least one trigger keyword
    has_trigger=0
    for kw in "${TRIGGER_KEYWORDS[@]}"; do
        if echo "$desc" | grep -qiE "(^|[[:space:][:punct:]])${kw}([[:space:][:punct:]]|$)"; then
            has_trigger=1
            break
        fi
    done

    if [ "$has_trigger" -eq 0 ]; then
        echo "  [WARN] $skill_name: Description lacks obvious trigger keyword (symptom/error/tool/situation)"
        echo "         $desc"
        WARNED=1
    fi
done

if [ "$FAILED" -eq 0 ] && [ "$WARNED" -eq 0 ]; then
    echo ""
    echo "All skill descriptions pass CSO validation!"
    exit 0
elif [ "$FAILED" -eq 0 ]; then
    echo ""
    echo "CSO validation passed with warnings."
    exit 0
else
    echo ""
    echo "CSO validation failed!"
    exit 1
fi
