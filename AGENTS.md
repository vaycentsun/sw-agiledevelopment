# sw-agiledevelopment — Agent 上下文

> **这是什么仓库：** 一个为 AI Coding Agent 设计的软件研发技能框架。"源码"是 `sw-*/` 目录下的 SKILL.md 文件，不是一个传统的代码项目。

## 编辑前必须知道的事

### 这是一个技能框架，不是应用
- "源码"是 `sw-*/` 目录下的 SKILL.md 文件。没有 `npm test`，没有构建步骤，也没有传统的应用入口。
- `package.json` 的存在只是为了 OpenCode 能通过 `git+` URL 安装插件。**不要**往里面添加依赖或脚本。
- `.opencode/plugins/sw-agiledevelopment.js` 插件通过两个钩子将技能注入会话：
  - `config` — 将仓库根目录注册到 `config.skills.paths`
  - `experimental.chat.messages.transform` — 在每个会话的第一条用户消息前，插入 `sw-using-agiledevelopment/SKILL.md` 内容
- `skills/` 目录是 Codex 插件兼容用的符号链接（指向 `sw-*/`）。**始终直接编辑 `sw-*/SKILL.md`**，不要通过 `skills/` 路径修改。

### 文件路径约定
- **Business Spec 文件**: `docs/sw-agiledevelopment/business-specs/YYYY-MM-DD--<feature-name>.md`
- **Technical Spec 文件**: `docs/sw-agiledevelopment/technical-specs/YYYY-MM-DD--<feature-name>.md`
- **计划文件**: `docs/sw-agiledevelopment/plans/YYYY-MM-DD--<feature-name>-plan.md`
- **Skill 目录**: `sw-<skill-name>/`
- **子 Agent 提示词**: `subagent-prompts/<name>-prompt.md`

### 指令优先级
本项目的技能覆盖默认系统提示，但**用户指令始终优先**：
1. 用户的明确指令（OPENCODE.md、CLAUDE.md、GEMINI.md、AGENTS.md、直接请求）
2. sw-agiledevelopment 技能
3. 默认系统提示

如果你编辑包含硬规则的技能（如"始终使用 TDD"），**不要**弱化它们。

### 验证变更
```bash
# 运行 bash 测试套件（不是 npm test）
bash tests/opencode/run-tests.sh

# 运行单个测试
bash tests/opencode/run-tests.sh -t test-skill-structure.sh
```

### 激活 Pre-Push 钩子
```bash
ln -s ../../hooks/pre-push .git/hooks/pre-push
```
钩子会强制执行 SKILL.md 约束。注意：钩子使用 `-gt 600`（601 行以上才失败），而测试套件在 600 行就会报 WARN。建议保持 `< 600` 行以同时通过两者。

### SKILL文件约束（钩子 + 测试双重验证）
| 约束 | 详情 |
|------|------|
| **Frontmatter** | 必须以 `---` 开头，包含 `name:` 和 `description:` |
| **行数限制** | ~500–600 行。超出的技能拆分成多个 `.md` 文件（参考 `sw-writing-skills/` 结构） |
| **红旗** | 必须包含 `## 红旗` 或 `## Red Flags` 章节 |
| **常见借口表** | 必须包含常见借口表格（如 `| 想法 | 现实 |`） |
| **命名** | 目录名必须匹配 `sw-<skill-name>/`，且与 frontmatter 中的 `name:` 字段一致 |

### 技能 Frontmatter 格式
```markdown
---
name: sw-example
description: "Use when [specific trigger condition]"
---
```
**重要：** 插件的 frontmatter 解析器是一个简单的基于冒号的解析器。**不要**使用复杂 YAML 特性，如多行字符串或嵌套对象。

## 添加或编辑技能时
1. 创建 `sw-<name>/` 目录，放入 `SKILL.md`。
2. 包含 frontmatter、红旗章节、常见借口表。
3. 编辑技能时遵循 `docs/terminology.md` 的中英文术语规范。
4. 提交前运行 `bash tests/opencode/run-tests.sh`。
5. 确保 `git push` 通过 pre-push 钩子。
6. 如果技能超出行数限制，在同一个 `sw-*/` 目录内拆成多个 `.md` 文件。

## 忽略的文件
- `.opencode/node_modules/`、`.opencode/package*.json` —— 插件开发依赖，不是项目源码。
- `tests/opencode/*.sh` 的输出 —— 测试是自包含且无状态的。

## 关键参考文档
- `docs/terminology.md` —— 所有 SKILL.md 必须遵循的中英文术语规范
- `sw-writing-skills/SKILL.md` —— 编写新技能的元技能
