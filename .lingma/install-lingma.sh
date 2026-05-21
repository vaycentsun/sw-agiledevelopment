#!/bin/bash

###############################################################################
# sw-agiledevelopment Framework - Lingma Installation Script
# 
# This script automates the installation of the sw-agiledevelopment framework
# as a global Lingma agent.
#
# Usage:
#   bash install-lingma.sh
#   or
#   curl -sSL https://raw.githubusercontent.com/vaycentsun/sw-agiledevelopment/main/scripts/install-lingma.sh | bash
###############################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/vaycentsun/sw-agiledevelopment.git"
REPO_DIR="/tmp/sw-agiledevelopment-check"
LINGMA_AGENTS_DIR="$HOME/.lingma/agents"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}sw-agiledevelopment Installation Script${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Step 1: Check prerequisites
echo -e "${YELLOW}Step 1: Checking prerequisites...${NC}"

if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Error: Git is not installed.${NC}"
    echo "Please install Git first: https://git-scm.com/downloads"
    exit 1
fi

if [ ! -d "$HOME/.lingma" ]; then
    echo -e "${YELLOW}⚠️  Warning: ~/.lingma directory not found.${NC}"
    echo "Lingma may not be installed. Continuing anyway..."
fi

echo -e "${GREEN}✅ Prerequisites check passed${NC}"
echo ""

# Step 2: Clone or update repository
echo -e "${YELLOW}Step 2: Setting up source repository...${NC}"

if [ -d "$REPO_DIR" ]; then
    echo "Repository already exists. Updating..."
    cd "$REPO_DIR"
    git pull origin main 2>/dev/null || {
        echo -e "${YELLOW}⚠️  Could not pull updates. Using existing repository.${NC}"
    }
else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

# Verify clone
if [ ! -d "$REPO_DIR" ]; then
    echo -e "${RED}❌ Error: Failed to clone repository${NC}"
    exit 1
fi

# Count skills
SKILL_COUNT=$(ls -d "$REPO_DIR"/sw-* 2>/dev/null | wc -l)
echo -e "${GREEN}✅ Repository ready ($SKILL_COUNT skills available)${NC}"
echo ""

# Step 3: Create Lingma agents directory
echo -e "${YELLOW}Step 3: Setting up Lingma agents directory...${NC}"

mkdir -p "$LINGMA_AGENTS_DIR"

if [ ! -d "$LINGMA_AGENTS_DIR" ]; then
    echo -e "${RED}❌ Error: Failed to create $LINGMA_AGENTS_DIR${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Agents directory created: $LINGMA_AGENTS_DIR${NC}"
echo ""

# Step 4: Install agent files
echo -e "${YELLOW}Step 4: Installing agent configuration files...${NC}"

# Check if template files exist in repo
if [ -f "$REPO_DIR/.lingma/sw-agile-developer.md" ]; then
    echo "Copying from repository templates..."
    cp "$REPO_DIR/.lingma/sw-agile-developer.md" "$LINGMA_AGENTS_DIR/sw-agile-developer.md"
    cp "$REPO_DIR/.lingma/SW-AGILE-QUICK-REF.md" "$LINGMA_AGENTS_DIR/SW-AGILE-QUICK-REF.md" 2>/dev/null || true
else
    echo -e "${YELLOW}⚠️  Template files not found in repository.${NC}"
    echo "Creating basic agent configuration..."
    
    # Create minimal sw-agile-developer.md
    cat > "$LINGMA_AGENTS_DIR/sw-agile-developer.md" << 'AGENT_EOF'
# sw-agiledevelopment - Agile Development Framework for Lingma

## Overview
This is the sw-agiledevelopment framework installed as a global Lingma agent.

**Repository**: https://github.com/vaycentsun/sw-agiledevelopment

## Available Skills
The framework provides 13 skills for agile development workflow:
- sw-requirements-clarification
- sw-technical-spec
- sw-working-plan
- sw-subagent-development
- sw-execute-plan
- sw-test-driven-dev
- sw-code-review
- sw-systematic-debugging
- sw-parallel-debugging
- sw-task-verification
- sw-finishing-branch
- sw-writing-skills
- sw-using-agiledevelopment

## How to Use
Invoke skills in Lingma using: Skill: <skill-name>

## Documentation
- Source: /tmp/sw-agiledevelopment-check/
- Skills: /tmp/sw-agiledevelopment-check/sw-*/SKILL.md
AGENT_EOF

    # Create minimal quick reference
    cat > "$LINGMA_AGENTS_DIR/SW-AGILE-QUICK-REF.md" << 'QUICK_EOF'
# sw-agiledevelopment Quick Reference

## Quick Start
1. Skill: sw-requirements-clarification
2. Skill: sw-technical-spec
3. Skill: sw-working-plan
4. Skill: sw-subagent-development

## File Locations
- Agent: ~/.lingma/agents/sw-agile-developer.md
- Source: /tmp/sw-agiledevelopment-check/
QUICK_EOF
fi

# Verify files were created
if [ ! -f "$LINGMA_AGENTS_DIR/sw-agile-developer.md" ]; then
    echo -e "${RED}❌ Error: Failed to create agent configuration${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Agent files installed${NC}"
echo ""

# Step 5: Set permissions
echo -e "${YELLOW}Step 5: Setting file permissions...${NC}"

chmod 644 "$LINGMA_AGENTS_DIR"/*.md 2>/dev/null || true
chmod 755 "$LINGMA_AGENTS_DIR"

echo -e "${GREEN}✅ Permissions set${NC}"
echo ""

# Step 6: Verification
echo -e "${YELLOW}Step 6: Verifying installation...${NC}"

ERRORS=0

# Check agent files
if [ -f "$LINGMA_AGENTS_DIR/sw-agile-developer.md" ]; then
    FILE_SIZE=$(stat -f%z "$LINGMA_AGENTS_DIR/sw-agile-developer.md" 2>/dev/null || stat -c%s "$LINGMA_AGENTS_DIR/sw-agile-developer.md" 2>/dev/null || echo "0")
    if [ "$FILE_SIZE" -gt 1000 ]; then
        echo -e "  ${GREEN}✅${NC} sw-agile-developer.md (${FILE_SIZE} bytes)"
    else
        echo -e "  ${RED}❌${NC} sw-agile-developer.md too small (${FILE_SIZE} bytes)"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo -e "  ${RED}❌${NC} sw-agile-developer.md missing"
    ERRORS=$((ERRORS + 1))
fi

if [ -f "$LINGMA_AGENTS_DIR/SW-AGILE-QUICK-REF.md" ]; then
    FILE_SIZE=$(stat -f%z "$LINGMA_AGENTS_DIR/SW-AGILE-QUICK-REF.md" 2>/dev/null || stat -c%s "$LINGMA_AGENTS_DIR/SW-AGILE-QUICK-REF.md" 2>/dev/null || echo "0")
    if [ "$FILE_SIZE" -gt 500 ]; then
        echo -e "  ${GREEN}✅${NC} SW-AGILE-QUICK-REF.md (${FILE_SIZE} bytes)"
    else
        echo -e "  ${YELLOW}⚠️${NC} SW-AGILE-QUICK-REF.md small (${FILE_SIZE} bytes)"
    fi
else
    echo -e "  ${YELLOW}⚠️${NC} SW-AGILE-QUICK-REF.md missing (optional)"
fi

# Check source repository
if [ -d "$REPO_DIR" ]; then
    SKILL_COUNT=$(ls -d "$REPO_DIR"/sw-* 2>/dev/null | wc -l)
    if [ "$SKILL_COUNT" -ge 13 ]; then
        echo -e "  ${GREEN}✅${NC} Source repository ($SKILL_COUNT skills)"
    else
        echo -e "  ${RED}❌${NC} Source repository incomplete ($SKILL_COUNT skills)"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo -e "  ${RED}❌${NC} Source repository missing"
    ERRORS=$((ERRORS + 1))
fi

echo ""

# Final result
echo -e "${BLUE}========================================${NC}"
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✅ Installation completed successfully!${NC}"
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo "  1. Open Lingma"
    echo "  2. Try invoking: Skill: sw-using-agiledevelopment"
    echo "  3. Read the guide: cat $LINGMA_AGENTS_DIR/sw-agile-developer.md"
    echo ""
    echo -e "${BLUE}Quick reference:${NC}"
    echo "  - Agent config: $LINGMA_AGENTS_DIR/sw-agile-developer.md"
    echo "  - Quick ref: $LINGMA_AGENTS_DIR/SW-AGILE-QUICK-REF.md"
    echo "  - Source repo: $REPO_DIR"
else
    echo -e "${RED}❌ Installation completed with $ERRORS error(s)${NC}"
    echo "Please review the errors above and fix them manually."
    exit 1
fi
echo -e "${BLUE}========================================${NC}"

exit 0
