# sw-superpower 术语规范

本文档定义 sw-superpower 技能框架中的中英文术语使用规范，确保所有 SKILL.md 文件、Agent 对话和用户文档在术语上保持一致。

## 使用原则

1. **技术术语优先保留英文**：行业内广泛认可的测试/开发术语（如 Mock, Spike, YAGNI）保留英文，首次出现时加注中文解释
2. **框架专属概念使用中文**：sw-superpower 内部概念（如 Skill, Spec）统一翻译为中文，但 `Agent` / `Subagent` 保留英文
3. **首次出现标注全称**：`中文（English）` 或 `英文（中文）`，后续直接使用确定形式
4. **禁止同一文档内混用**：同一篇 SKILL.md 中，同一个概念不可既用中文又用英文

---

## 术语对照表

### 框架核心概念（统一使用中文）

| 禁用形式 | 规范形式 | 说明 |
|---------|---------|------|
| Skill / skill | **技能** | 框架核心概念，统一译为"技能" |
| Agent / agent | **Agent** | AI 编程助手，保留英文 |
| Subagent / subagent | **Subagent** | 被分派执行任务的 Agent 实例，保留英文 |
| Business-spec | **business-spec** | `docs/sw-superpower/business-specs/` 中的文档，保留英文 |
| Technical-spec / Tech-spec | **technical-spec** | `docs/sw-superpower/technical-specs/` 中的文档，保留英文 |
| Spec / spec | **spec** | 泛指 technical-spec 或 business-spec，保留英文 |
| Brainstorming (旧称) | **需求澄清** | requirements-clarification 阶段 |
| Working-plan | **working-plan** | `docs/sw-superpower/plans/` 中的文档，保留英文 |
| Red flag / red flag | **红旗** | 警告信号，章节标题固定为 `## 红旗` |
| Frontmatter | **Frontmatter** | 保留英文，指 Markdown 文件头部的 `---` 元数据块 |
| Pre-push hook | **预推送钩子** | Git 钩子，保留 `pre-push` 指代脚本文件名 |

### 软件开发术语（保留英文，首次出现加注中文）

| 术语 | 首次出现写法 | 后续使用 |
|------|-------------|---------|
| TDD | 测试驱动开发（TDD, Test-Driven Development） | TDD 或 测试驱动开发 |
| RED-GREEN-REFACTOR | RED-GREEN-REFACTOR（红-绿-重构循环） | RED-GREEN-REFACTOR 循环 |
| Mock | Mock（模拟对象） | Mock |
| Spike | Spike（探索性原型） | Spike |
| YAGNI | YAGNI（You Aren't Gonna Need It，你不需要它） | YAGNI |
| DRY | DRY（Don't Repeat Yourself，不要重复自己） | DRY |
| API | API（应用程序接口） | API |
| JWT | JWT（JSON Web Token） | JWT |
| OAuth | OAuth（开放授权协议） | OAuth |
| TODO | 待办事项（TODO） | 待办事项 或 TODO |
| TBD | 待定（TBD, To Be Determined） | 待定 或 TBD |
| Token | **token** | 保留英文 |

### 框架流程术语（统一使用中文）

| 禁用形式 | 规范形式 | 说明 |
|---------|---------|------|
| Context compression | **上下文压缩** | 释放对话历史 token 以节省上下文空间的操作 |
| 测试后置 | **测试后置** | 先写实现代码再补测试的做法，TDD 中明确禁止 |

### TDD 专属术语

| 禁用形式 | 规范形式 |
|---------|---------|
| Red 阶段 / RED 阶段 | **RED**（编写失败测试） |
| Green 阶段 / GREEN 阶段 | **GREEN**（编写最简实现） |
| Refactor 阶段 | **REFACTOR**（清理代码） |
| 生产代码 | **生产代码**（production code，不可写为 "production code"） |
| 最简代码 | **最简代码**（minimal code，指刚好让测试通过的实现） |

### 文件与目录术语

| 英文路径/术语 | 中文指称 | 备注 |
|-------------|---------|------|
| `sw-*/SKILL.md` | **技能文件** | 每个技能目录下的主文件 |
| `subagent-prompts/` | **Subagent 提示词目录** | 存放 `-prompt.md` 文件 |
| `docs/sw-superpower/business-specs/` | **business-specs 目录** | 存放业务需求文档 |
| `docs/sw-superpower/technical-specs/` | **technical-specs 目录** | 存放技术设计文档 |
| `docs/sw-superpower/plans/` | **plans 目录** | 存放 working-plan 文档 |

---

## 场景示例

### ❌ 错误示例（中英混用）

> "智能体展示每节设计后自动推进到下一节。用户如有根本性异议可随时打断。"
> 
> "先写测试再写代码？删除它。重新开始。"
> 
> "编写 spec 文档后立即开始编码。"

### ✅ 正确示例（术语统一）

> "Agent 展示每节设计后自动推进到下一节。用户如有根本性异议可随时打断。"
> 
> "已经先写了实现代码？删掉它，从头开始。"
> 
> "编写 technical-spec 文档后立即开始编码。"

---

## 新增技能时的术语检查

在创建或编辑 SKILL.md 时，请对照此表检查：

- [ ] 框架核心概念是否使用了中文规范形式
- [ ] 技术术语首次出现是否加注了中文解释
- [ ] 同一概念在全文内是否保持形式一致
- [ ] TDD 相关阶段是否使用 RED/GREEN/REFACTOR 大写形式

---

## 更新记录

- **2026-05-12**: 初始版本，基于 sw-test-driven-dev、sw-requirements-clarification、sw-technical-spec 的优化经验建立
