# sw-agiledevelopment Framework - Lingma Installation Guide

## Overview

This guide provides step-by-step instructions for installing the **sw-agiledevelopment** framework as a global Lingma agent. This framework provides a complete set of software engineering workflow skills for AI coding agents, enabling systematic development from requirements analysis to code review.

**Repository**: https://github.com/vaycentsun/sw-agiledevelopment

---

## Prerequisites

- **Lingma** installed and configured on your system
- **Git** installed (for cloning the repository)
- **Bash/Zsh** shell access
- Internet connection (for initial clone)

---

## Quick Installation (Automated)

For users who want a one-command installation, run this script:

```bash
curl -sSL https://raw.githubusercontent.com/vaycentsun/sw-agiledevelopment/main/scripts/install-lingma.sh | bash
```

Or manually execute the installation script after cloning:

```bash
git clone https://github.com/vaycentsun/sw-agiledevelopment.git /tmp/sw-agiledevelopment-check
cd /tmp/sw-agiledevelopment-check
bash scripts/install-lingma.sh
```

---

## Manual Installation (Step-by-Step)

### Step 1: Clone the Repository

```bash
git clone https://github.com/vaycentsun/sw-agiledevelopment.git /tmp/sw-agiledevelopment-check
```

Verify the clone was successful:

```bash
ls -la /tmp/sw-agiledevelopment-check/
```

You should see directories like `sw-requirements-clarification/`, `sw-technical-spec/`, etc.

### Step 2: Create Lingma Agents Directory

```bash
mkdir -p ~/.lingma/agents
```

Verify the directory exists:

```bash
ls -la ~/.lingma/
```

### Step 3: Install Agent Configuration Files

The framework requires two files in `~/.lingma/agents/`:

#### 3.1 Main Agent Configuration

Create or copy the main agent file:

```bash
# Option A: Copy from template (if available in repo)
cp /tmp/sw-agiledevelopment-check/.lingma/sw-agile-developer.md ~/.lingma/agents/sw-agile-developer.md

# Option B: Download from repository
curl -sSL https://raw.githubusercontent.com/vaycentsun/sw-agiledevelopment/main/.lingma/sw-agile-developer.md \
  -o ~/.lingma/agents/sw-agile-developer.md
```

#### 3.2 Quick Reference Guide

Create or copy the quick reference:

```bash
# Option A: Copy from template (if available in repo)
cp /tmp/sw-agiledevelopment-check/.lingma/SW-AGILE-QUICK-REF.md ~/.lingma/agents/SW-AGILE-QUICK-REF.md

# Option B: Download from repository
curl -sSL https://raw.githubusercontent.com/vaycentsun/sw-agiledevelopment/main/.lingma/SW-AGILE-QUICK-REF.md \
  -o ~/.lingma/agents/SW-AGILE-QUICK-REF.md
```

### Step 4: Verify Installation

Check that all files are in place:

```bash
ls -lh ~/.lingma/agents/
```

Expected output:
```
-rw-r--r--  1 user  staff   7.0K May 21 11:11 sw-agile-developer.md
-rw-r--r--  1 user  staff   2.2K May 21 11:12 SW-AGILE-QUICK-REF.md
```

Verify file sizes are reasonable (>1KB each).

### Step 5: Test the Installation

Open Lingma and try invoking a skill:

```
Skill: sw-using-agiledevelopment
```

If the skill loads successfully, the installation is complete!

---

## What Gets Installed

### 📁 File Structure

```
~/.lingma/agents/
├── sw-agile-developer.md      # Main agent configuration (7KB)
└── SW-AGILE-QUICK-REF.md      # Quick reference guide (2.2KB)

/tmp/sw-agiledevelopment-check/  # Source repository (13 skills)
├── sw-requirements-clarification/
├── sw-technical-spec/
├── sw-working-plan/
├── sw-subagent-development/
├── sw-execute-plan/
├── sw-test-driven-dev/
├── sw-code-review/
├── sw-systematic-debugging/
├── sw-parallel-debugging/
├── sw-task-verification/
├── sw-finishing-branch/
├── sw-writing-skills/
└── sw-using-agiledevelopment/
```

### 🎯 Available Skills (13 Total)

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| `sw-requirements-clarification` | Transform ideas into business requirements | Starting new feature |
| `sw-technical-spec` | Write structured technical specification | Requirements clarified |
| `sw-working-plan` | Create detailed implementation plans | Need execution plan |
| `sw-subagent-development` | Execute plans using subagents | Tasks are independent |
| `sw-execute-plan` | Execute plans in same session | Not using subagents |
| `sw-test-driven-dev` | Enforce RED-GREEN-REFACTOR cycle | Implementing or fixing |
| `sw-code-review` | Request & handle code review feedback | After task, before merge |
| `sw-systematic-debugging` | Systematic bug investigation | Bugs or test failures |
| `sw-parallel-debugging` | Parallel debugging | 2+ independent failures |
| `sw-task-verification` | Verify task completion | Ready to mark complete |
| `sw-finishing-branch` | Verify, decide, and clean up branch | All tasks completed |
| `sw-writing-skills` | Create and validate new skills | Need a new skill |
| `sw-using-agiledevelopment` | Skill system bootstrap | Every conversation start |

---

## Usage Guide

### Basic Workflow for New Features

Follow this sequence when starting a new feature:

```bash
# 1. Clarify requirements
Skill: sw-requirements-clarification
# Output: docs/sw-agiledevelopment/business-specs/YYYY-MM-DD--feature.md

# 2. Create technical specification
Skill: sw-technical-spec
# Output: docs/sw-agiledevelopment/technical-specs/YYYY-MM-DD--feature.md

# 3. Create implementation plan
Skill: sw-working-plan
# Output: docs/sw-agiledevelopment/plans/YYYY-MM-DD--feature-plan.md

# 4. Execute with subagents
Skill: sw-subagent-development
# Automatically handles parallel execution and two-phase review
```

### Bug Fix Workflow

```bash
# 1. Investigate the bug
Skill: sw-systematic-debugging

# 2. Fix with TDD
Skill: sw-test-driven-dev

# 3. Review the fix
Skill: sw-code-review

# 4. Verify completion
Skill: sw-task-verification
```

### Parallel Task Execution

When you have multiple independent tasks:

```bash
Skill: sw-subagent-development
```

This automatically:
- Scans for ready tasks
- Dispatches subagents in parallel
- Performs two-phase review (Spec compliance → Code quality)
- Commits completed tasks

---

## Key Principles

### ⚠️ Critical Rules

1. **ALWAYS invoke skills**: If there's even a 1% chance a skill applies, you MUST use it
2. **Skills are NOT optional**: When applicable, skills must be used - no exceptions
3. **Two-phase review**: Always do Spec compliance review first, then Code quality review
4. **Fresh context**: Each subagent gets isolated, focused context
5. **Maximum 3 iterations**: Per review phase (spec or code quality)

### Instruction Priority

1. **User's explicit instructions** (highest priority)
2. **Agile Development skills** (override default behavior)
3. **Default system prompts** (lowest priority)

### File Path Conventions

Generated files follow this structure:

```
docs/sw-agiledevelopment/
├── business-specs/
│   └── YYYY-MM-DD--<feature-name>.md
├── technical-specs/
│   └── YYYY-MM-DD--<feature-name>.md
└── plans/
    └── YYYY-MM-DD--<feature-name>-plan.md
```

---

## Troubleshooting

### Skills Not Loading

**Problem**: Skills don't appear when invoked

**Solutions**:
1. Verify files exist: `ls -lh ~/.lingma/agents/`
2. Check file permissions: `chmod 644 ~/.lingma/agents/*.md`
3. Ensure source repo is accessible: `ls /tmp/sw-agiledevelopment-check/sw-*/`
4. Restart Lingma if necessary

### Subagent Issues

**Problem**: Subagents not executing properly

**Solutions**:
1. Ensure tasks are truly independent
2. Provide clear, focused instructions
3. Don't share unnecessary context between subagents
4. Check that `sw-subagent-development` skill is loaded

### Review Failures

**Problem**: Reviews keep failing

**Solutions**:
1. **Spec review fails**: Fix spec compliance issues first
2. **Code quality fails**: Address quality issues before proceeding
3. Maximum 3 iterations per phase - if still failing, reassess approach
4. Read the specific skill documentation for detailed guidance

### Permission Errors

**Problem**: Cannot write to `~/.lingma/agents/`

**Solution**:
```bash
# Fix directory permissions
chmod 755 ~/.lingma/agents/

# Fix file permissions
chmod 644 ~/.lingma/agents/*.md
```

---

## Updating the Framework

To update to the latest version:

```bash
# Navigate to source repository
cd /tmp/sw-agiledevelopment-check

# Pull latest changes
git pull origin main

# Re-install agent files (if they've changed)
cp .lingma/sw-agile-developer.md ~/.lingma/agents/sw-agile-developer.md
cp .lingma/SW-AGILE-QUICK-REF.md ~/.lingma/agents/SW-AGILE-QUICK-REF.md
```

Or use the automated update script (if available):

```bash
bash /tmp/sw-agiledevelopment-check/scripts/update-lingma.sh
```

---

## Uninstallation

To remove the framework:

```bash
# Remove agent files
rm ~/.lingma/agents/sw-agile-developer.md
rm ~/.lingma/agents/SW-AGILE-QUICK-REF.md

# Optionally remove source repository
rm -rf /tmp/sw-agiledevelopment-check
```

---

## Verification Checklist

After installation, verify everything works:

- [ ] `~/.lingma/agents/` directory exists
- [ ] `sw-agile-developer.md` file exists (>5KB)
- [ ] `SW-AGILE-QUICK-REF.md` file exists (>1KB)
- [ ] Source repository cloned to `/tmp/sw-agiledevelopment-check/`
- [ ] At least 13 skill directories present in source repo
- [ ] Can invoke `Skill: sw-using-agiledevelopment` in Lingma
- [ ] Skills load without errors

Run this verification command:

```bash
echo "=== Installation Verification ===" && \
ls -lh ~/.lingma/agents/ && \
echo "" && \
echo "Source repo skills:" && \
ls -d /tmp/sw-agiledevelopment-check/sw-* | wc -l && \
echo "" && \
echo "✅ Installation complete!" || echo "❌ Installation failed"
```

---

## Support & Resources

### Documentation
- **Full Agent Guide**: `~/.lingma/agents/sw-agile-developer.md`
- **Quick Reference**: `~/.lingma/agents/SW-AGILE-QUICK-REF.md`
- **Original README**: `/tmp/sw-agiledevelopment-check/README.md`
- **Individual Skills**: `/tmp/sw-agiledevelopment-check/sw-<skill-name>/SKILL.md`

### Getting Help
- **GitHub Issues**: https://github.com/vaycentsun/sw-agiledevelopment/issues
- **Documentation**: See individual skill files for detailed workflows
- **Community**: Check the repository for discussions and examples

### Additional Languages
The framework supports multiple languages:
- 🇺🇸 English: `README.md`
- 🇨🇳 中文: `README.zh.md`
- 🇯🇵 日本語: `README.ja.md`
- 🇪🇸 Español: `README.es.md`
- 🇫🇷 Français: `README.fr.md`

---

## Best Practices

1. **Always start with requirements**: Never skip the clarification phase
2. **Use subagents for parallel work**: Leverage when tasks are independent
3. **Follow TDD strictly**: Write tests before implementation (RED → GREEN → REFACTOR)
4. **Review in phases**: Spec compliance before code quality
5. **Document everything**: Generate proper spec and plan files
6. **Verify before completing**: Use verification skills before marking tasks done
7. **Keep skills updated**: Regularly pull latest changes from repository

---

## Version Information

- **Installation Date**: 2026-05-21
- **Framework Version**: Check `/tmp/sw-agiledevelopment-check/VERSION`
- **Agent Config Version**: See header in `sw-agile-developer.md`
- **Last Updated**: Check git log in source repository

---

## License

This framework is licensed under the [MIT License](https://github.com/vaycentsun/sw-agiledevelopment/blob/main/LICENSE).

---

**Happy Agile Development! 🚀**

*For questions or issues, visit: https://github.com/vaycentsun/sw-agiledevelopment*
