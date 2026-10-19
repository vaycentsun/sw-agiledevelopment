# DeepSeek Harness（DSH）工具映射

Skills 使用 Claude Code 工具名称。遇到这些时，使用 DSH 的等效项：

| Skill 引用 | DSH 等效项 |
|-----------|-----------|
| `Read`（文件读取） | `read` |
| `Write`（文件创建） | `write` |
| `Edit`（文件编辑） | `edit` |
| `Bash`（运行命令） | `bash` |
| `Grep`（搜索文件内容） | `grep` |
| `Glob`（按名称搜索文件） | `glob` |
| `TodoWrite`（任务跟踪） | `todo_write` |
| `Skill` 工具（调用技能） | `skill` |
| `WebSearch` | `web_search` |
| `WebFetch` | `web_fetch` |
| `Task` 工具（分派子 Agent） | `subagent`（独立任务）或 `subagent_fork`（继承当前上下文） |

## 技能发现与调用

DSH 原生支持 `SKILL.md`：

- 安装脚本把每个 `sw-*/` 目录链接到 `<dshHome>/skills/`（默认 `~/.dsh/skills/`）。
- 会话开始时，DSH 自动把可用技能的 `name` 和 `description` 注入技能目录。
- 需要某个技能时，调用 `skill` 工具并传入精确名称，例如 `skill({ name: "sw-test-driven-dev" })`。正文加载后直接遵循。
- 用户可以用 `/sw-using-agiledevelopment` 直接调用技能。
- **不要**用 `read` 工具手动读取 `SKILL.md`：`skill` 工具会返回规范化的技能正文和资源基目录。

## 子 Agent 与并行工作

DSH 支持子 Agent，因此 `sw-subagent-development` 和 `sw-parallel-debugging` 可以按原样使用：

| 场景 | 推荐工具 |
|------|---------|
| 一个边界清晰的独立任务 | `subagent` |
| 需要继承当前对话上下文的后续分析 | `subagent_fork` |
| 大量独立文件或任务的批量审计、迁移 | `workflow` |
| 等待后台命令或测试 | `bash` 的 `run_in_background` + `job_output` |

子 Agent 的结果通过 `send_message` 汇报；不要用轮询等待子 Agent 完成。

## 其他 DSH 工具

| 工具 | 用途 |
|------|------|
| `ask_user_question` | 向用户提出结构化问题（需求澄清时优先使用） |
| `present` | 把最终文件声明为可打开的交付物 |
| `workflow` | 用 JavaScript 脚本编排大量子 Agent，适合批量审计、迁移、多角度研究 |
| `create_goal` / `update_goal` | 创建和推进跨轮次的长任务目标 |
| `schedule_create` | 创建会话内提醒 |
| `job_output` / `job_kill` | 读取或停止后台任务 |

## 文件策略与审批

DSH 默认在 workspace-write 文件策略下运行：写入限制在会话工作区内，越界操作可能触发审批。执行 `bash`、`write`、`edit` 时如果遇到策略拒绝，不要换一种方式绕过；向用户说明需要更宽的权限或调整工作区。
