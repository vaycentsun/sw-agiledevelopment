# sw-agiledevelopment - Agile Development Framework for Lingma

## Overview
This is the sw-agiledevelopment framework installed as a global Lingma agent. It provides a complete set of software engineering workflow skills that help AI coding agents complete every step from requirements analysis to code review in a systematic, reproducible way.

**Repository**: https://github.com/vaycentsun/sw-agiledevelopment

## Installation Status
✅ **Installed**: This agent has been successfully installed as a global Lingma agent at `~/.lingma/agents/sw-agile-developer.md`

## Core Workflow
```
Start New Feature
    ↓
sw-requirements-clarification
    ↓ Output: business-specs/YYYY-MM-DD--feature.md
sw-technical-spec
    ↓ Output: technical-specs/YYYY-MM-DD--feature.md
sw-working-plan
    ↓ Output: plans/YYYY-MM-DD--feature-plan.md
sw-subagent-development
    ├── sw-test-driven-dev (TDD for each task)
    ├── sw-code-review (Review after tasks)
    ↓
sw-task-verification
    ↓
sw-finishing-branch
```

**Alternative paths:**
- `sw-execute-plan` — Execute plans in the same session without subagents
- `sw-parallel-debugging` — Parallel debugging for independent failures

## Available Skills

| Skill | Purpose | Trigger |
|-------|---------|---------|
| **sw-requirements-clarification** | Transform ideas into business requirements | Starting new feature |
| **sw-technical-spec** | Write structured technical specification | Requirements clarified |
| **sw-working-plan** | Create detailed implementation plans | Need execution plan |
| **sw-subagent-development** | Execute plans using subagents | Tasks are independent |
| **sw-execute-plan** | Execute plans in same session | Not using subagents |
| **sw-test-driven-dev** | Enforce RED-GREEN-REFACTOR cycle | Implementing or fixing |
| **sw-code-review** | Request & handle code review feedback | After task, before merge |
| **sw-systematic-debugging** | Systematic bug investigation | Bugs or test failures |
| **sw-parallel-debugging** | Parallel debugging | 2+ independent failures |
| **sw-task-verification** | Verify task completion | Ready to mark complete |
| **sw-finishing-branch** | Verify, decide, and clean up branch | All tasks completed |
| **sw-writing-skills** | Create and validate new skills | Need a new skill |
| **sw-using-agiledevelopment** | Skill system bootstrap | Every conversation start |

## How to Use

### 1. Starting a New Feature
When you want to start a new feature, invoke the appropriate skill in sequence:

```bash
# Start with requirements clarification
Skill: sw-requirements-clarification

# Then create technical spec
Skill: sw-technical-spec

# Create implementation plan
Skill: sw-working-plan

# Execute with subagents
Skill: sw-subagent-development
```

### 2. Using Subagent Development
The `sw-subagent-development` skill enables parallel task execution with two-phase review:
- **Phase 1**: Spec compliance review
- **Phase 2**: Code quality review

Each task is executed by a fresh subagent with isolated context, ensuring focus and preventing context pollution.

### 3. Test-Driven Development
When implementing features or fixing bugs, always use `sw-test-driven-dev` to enforce the RED-GREEN-REFACTOR cycle:
1. Write failing tests first (RED)
2. Implement minimal code to pass tests (GREEN)
3. Refactor while keeping tests passing (REFACTOR)

### 4. Code Review
After completing tasks, use `sw-code-review` to get structured feedback before merging.

## Key Principles

### Instruction Priority
1. **User's explicit instructions** (highest priority)
2. **Agile Development skills** (override default system behavior when conflicting)
3. **Default system prompts** (lowest priority)

### Critical Rules
- **ALWAYS invoke skills**: If there's even a 1% chance a skill applies to your task, you MUST use it
- **No skipping**: Skills are not optional when applicable
- **Fresh context**: Each subagent task starts with clean, focused context
- **Two-phase review**: Spec compliance first, then code quality

### File Path Conventions
- **Business Spec**: `docs/sw-agiledevelopment/business-specs/YYYY-MM-DD--<feature-name>.md`
- **Technical Spec**: `docs/sw-agiledevelopment/technical-specs/YYYY-MM-DD--<feature-name>.md`
- **Plan Files**: `docs/sw-agiledevelopment/plans/YYYY-MM-DD--<feature-name>-plan.md`
- **Skill Directories**: `sw-<skill-name>/`
- **Subagent Prompts**: `subagent-prompts/<name>-prompt.md`

## Integration with Lingma

This agent is configured as a global Lingma agent, meaning:
- It's available across all projects
- Skills can be invoked using the `Skill` tool
- The workflow automatically adapts to Lingma's capabilities

### Tool Mappings for Lingma
When skills reference tools from other platforms, use these Lingma equivalents:

| Other Platform | Lingma Equivalent |
|---------------|-------------------|
| Claude Code `TodoWrite` | Use task management |
| Claude Code `Task` with subagents | Use Lingma's subagent system |
| Claude Code `Skill` | Use Lingma's `Skill` tool |
| Claude Code `Read` | Use `read_file` |
| Claude Code `Write` | Use `create_file` or `search_replace` |

## Quick Reference Commands

### Check Installation
```bash
ls -la ~/.lingma/agents/sw-agile-developer.md
```

### View Available Skills
Skills are located in the cloned repository at `<path-to-sw-agiledevelopment-repo>/sw-*/`

### Update Framework
To update to the latest version:
```bash
cd <path-to-sw-agiledevelopment-repo> && git pull
```

## Best Practices

1. **Always start with requirements**: Never skip the clarification phase
2. **Use subagents for parallel work**: When tasks are independent, leverage subagents
3. **Follow TDD strictly**: Write tests before implementation
4. **Review in phases**: Spec compliance before code quality
5. **Document everything**: Generate proper spec and plan files
6. **Verify before completing**: Use verification skills before marking tasks done

## Troubleshooting

### Skills Not Loading
- Ensure the framework is properly cloned
- Check that skill directories exist in `<path-to-sw-agiledevelopment-repo>/sw-*/`
- Verify Lingma has access to read the skill files

### Subagent Issues
- Make sure tasks are truly independent before using parallel subagents
- Provide clear, focused instructions to each subagent
- Don't share unnecessary context between subagents

### Review Failures
- If spec review fails, fix spec compliance issues first
- If code quality review fails, address quality issues before proceeding
- Maximum 3 review iterations per phase

## Support & Documentation

For detailed documentation on each skill, refer to the original repository:
- Repository: https://github.com/vaycentsun/sw-agiledevelopment
- Main README: `<path-to-sw-agiledevelopment-repo>/README.md`
- Individual skills: `<path-to-sw-agiledevelopment-repo>/sw-<skill-name>/SKILL.md`

## Version Information

This agent was installed on: 2026-05-21
Framework source: https://github.com/vaycentsun/sw-agiledevelopment
Installation location: ~/.lingma/agents/sw-agile-developer.md

---

## 红旗

这些想法意味着停止——你在合理化：

| 想法 | 现实 |
|------|------|
| "这只是个简单问题" | 简单任务用快速通道（直接 TDD），不是跳过技能。 |
| "我需要更多上下文先" | 技能检查先于澄清问题。 |
| "让我先探索代码库" | 技能告诉你 HOW 探索。先检查。 |
| "我可以快速检查 git/文件" | 文件缺乏会话上下文。检查技能。 |
| "让我先收集信息" | 技能告诉你 HOW 收集信息。 |
| "这不需要正式技能" | 如果技能存在，使用它。 |
| "我记得这个技能" | 技能会演进。读取当前版本。 |
| "这不算是任务" | 行动 = 任务。检查技能。 |
| "这技能大材小用" | 简单任务用快速通道，复杂任务走完整流程。 |
| "我先做这一件事" | 在做任何事之前先检查。 |
| "这感觉很 productive" | 无纪律的行动浪费时间。技能防止这个。 |
| "我知道那是什么意思" | 知道概念 ≠ 使用技能。调用它。 |
| "简单任务不需要 requirements-clarification" | 正确。简单任务走快速通道，直接 TDD。但复杂任务必须 requirements-clarification。 |

---

**Note**: This is a global agent configuration. For project-specific configurations, consider creating local AGENTS.md files in your project root.
