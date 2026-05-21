# sw-agiledevelopment Quick Reference

## 🚀 Quick Start Commands

### Invoke Skills in Order
```
1. Skill: sw-requirements-clarification
2. Skill: sw-technical-spec  
3. Skill: sw-working-plan
4. Skill: sw-subagent-development
```

### For Bug Fixes
```
1. Skill: sw-systematic-debugging
2. Skill: sw-test-driven-dev
3. Skill: sw-code-review
```

### For Independent Tasks
```
Skill: sw-subagent-development (parallel execution)
```

## 📋 Skill Triggers

| When to use | Skill |
|------------|-------|
| Starting new feature | `sw-requirements-clarification` |
| After requirements clear | `sw-technical-spec` |
| Need implementation plan | `sw-working-plan` |
| Execute with subagents | `sw-subagent-development` |
| Execute without subagents | `sw-execute-plan` |
| Writing code/tests | `sw-test-driven-dev` |
| After task completion | `sw-code-review` |
| Debugging issues | `sw-systematic-debugging` |
| Multiple bugs | `sw-parallel-debugging` |
| Verify completion | `sw-task-verification` |
| Finish branch | `sw-finishing-branch` |

## ⚠️ Critical Rules

✅ **ALWAYS** invoke skills when applicable (even 1% chance)
✅ **ALWAYS** follow TDD: RED → GREEN → REFACTOR
✅ **ALWAYS** do two-phase review: Spec → Code Quality
✅ **NEVER** skip requirements clarification
✅ **NEVER** share context between subagents unnecessarily

## 📁 File Locations

- **Agent Config**: `~/.lingma/agents/sw-agile-developer.md`
- **Quick Ref**: `~/.lingma/agents/SW-AGILE-QUICK-REF.md`
- **Source Repo**: `/tmp/sw-agiledevelopment-check/`
- **Skills**: `/tmp/sw-agiledevelopment-check/sw-*/SKILL.md`

## 🔄 Workflow Summary

```
New Feature:
Requirements → Tech Spec → Plan → Subagents → Review → Verify → Finish

Bug Fix:
Debug → TDD → Review → Verify

Parallel Tasks:
Plan → Batch Subagents → Parallel Review → Verify
```

## 💡 Pro Tips

1. **Subagents work best** when tasks are truly independent
2. **Spec compliance** must pass before code quality review
3. **Maximum 3 iterations** per review phase
4. **Document everything** in proper spec/plan files
5. **Fresh context** for each subagent = better focus

---
For full documentation: `~/.lingma/agents/sw-agile-developer.md`
