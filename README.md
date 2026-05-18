<div align="right">
  <strong>🇺🇸 English</strong> | <a href="./README.zh.md">🇨🇳 中文</a> | <a href="./README.ja.md">🇯🇵 日本語</a> | <a href="./README.es.md">🇪🇸 Español</a> | <a href="./README.fr.md">🇫🇷 Français</a>
</div>

# sw-agiledevelopment 🦸

> An Agile Development skill set for AI coding agents — structured software engineering workflows from requirements clarification to code review.

A complete set of software engineering workflow skills that help AI coding agents complete every step from requirements analysis to code review in a systematic, reproducible way.

---

## 🚀 Quick Start

### Installation

**OpenCode Plugin (Recommended):**

Add to your `~/.config/opencode/opencode.json`:

```json
{
  "plugin": [
    "sw-agiledevelopment@git+https://github.com/vaycentsun/sw-agiledevelopment.git#main"
  ],
  "permission": {
    "skill": {
      "*": "allow"
    }
  }
}
```

Restart OpenCode. The plugin will be auto-installed via Bun.

**Git Submodule:**

```bash
cd <your-project>/skills/
git submodule add https://github.com/vaycentsun/sw-agiledevelopment.git
git submodule update --init --recursive
```

Restart OpenCode or reload skills.

---

## 🗺️ Core Workflow

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

---

## 📋 Skills

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

---

## 📄 License

[MIT](./LICENSE)

---

## 🙏 Acknowledgements

- Based on the Agile Development methodology, originally inspired by the [Superpowers](https://github.com/obra/superpowers) skill format
- Inspired by mature software engineering practices
