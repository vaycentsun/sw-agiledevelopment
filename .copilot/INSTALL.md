# 📦 SW-AGILEDEVELOPMENT VS CODE EXTENSION 安装指南

> **给 AI Agent 和开发者的说明**：按照以下步骤完成 sw-agiledevelopment 扩展的安装，之后在 Copilot Chat 中就能使用。

## ✅ 前置要求

在安装前，请确保你已经有：

- ✓ **VS Code** 1.90+ 版本
- ✓ **GitHub Copilot Chat** 扩展已安装
- ✓ **有效的 Copilot 订阅**（免费或付费）

## 🚀 安装步骤（3 步，2 分钟完成）

### 步骤 1️⃣：打开 VS Code 扩展市场

在 VS Code 中：

1. 按 **Ctrl+Shift+X**（Windows/Linux）或 **Cmd+Shift+X**（Mac）
2. 或点击左侧活动栏的 **扩展** 图标

### 步骤 2️⃣：搜索并安装

1. 在搜索框输入：**sw-agiledevelopment**
2. 找到 "Agile Development - sw-agiledevelopment" 扩展
3. 点击 **Install** 按钮

等待安装完成（通常 30 秒内）。

### 步骤 3️⃣：刷新 Copilot Chat

1. 重新加载 VS Code：按 **Ctrl+R**（Windows/Linux）或 **Cmd+R**（Mac）
2. 或点击 VS Code 右下角的 "Reload" 按钮

完成！✅

---

## 🧪 验证安装成功

### 方法 1：在 Copilot Chat 中测试

1. 打开 Copilot Chat（**Ctrl+L** 或 **Cmd+L**）
2. 输入：`@sw-agiledevelopment /list`
3. 按 Enter

**预期结果**：看到所有可用的开发技能列表

### 方法 2：查看扩展列表

1. 打开扩展面板（**Ctrl+Shift+X** 或 **Cmd+Shift+X**）
2. 搜索 "sw-agiledevelopment"
3. 应该看到 "已安装" 标签

✅ 如果你看到上述任何一个，说明安装成功了！

---

## 💡 基本用法

### 列出所有可用技能

```
@sw-agiledevelopment /list
```

看到所有开发技能（技术规格、测试驱动开发、调试等）

### 获取特定技能的详细指导

```
@sw-agiledevelopment /skill sw-technical-spec
```

获取关于"技术规格编写"的完整指南

或

```
@sw-agiledevelopment /skill sw-test-driven-dev
```

获取关于"测试驱动开发"的完整指南

### 自然语言查询

```
@sw-agiledevelopment 我需要调试代码，有什么建议吗？
```

系统会自动推荐相关的调试技能

---

## 📋 可用的技能清单

以下是 sw-agiledevelopment 中包含的主要技能：

| 技能 | 命令 | 用途 |
|------|------|------|
| 技术规格 | `/skill sw-technical-spec` | 编写高质量的技术设计文档 |
| 测试驱动开发 | `/skill sw-test-driven-dev` | 遵循 TDD 最佳实践 |
| 需求澄清 | `/skill sw-requirements-clarification` | 明确和验证需求 |
| 系统调试 | `/skill sw-systematic-debugging` | 有效调试的方法论 |
| 代码审查 | `/skill sw-code-review` | 进行高质量的代码审查 |
| 任务验证 | `/skill sw-task-verification` | 验证工作完成质量 |
| 执行计划 | `/skill sw-execute-plan` | 按计划有序执行 |
| 工作计划 | `/skill sw-working-plan` | 制定和管理工作计划 |

---

## ⚠️ 故障排查

### 问题 1：搜不到 "sw-agiledevelopment" 扩展

**原因**：扩展可能还在发布中，或者应用商店有缓存

**解决方案**：

1. 检查你的 VS Code 版本是否 ≥ 1.90
2. 重新启动 VS Code
3. 清空应用商店缓存：
   - 打开扩展面板
   - 点击 ⋮ 菜单 → "Reload Extensions"
4. 再次搜索

### 问题 2：安装后 @sw-agiledevelopment 不显示

**原因**：扩展加载中或 Copilot Chat 需要刷新

**解决方案**：

1. 确保已安装 "GitHub Copilot Chat" 扩展
2. 重新加载 VS Code（**Ctrl+R** 或 **Cmd+R**）
3. 重新启动 Copilot Chat（关闭并重新打开）
4. 尝试在 Chat 中输入 `@sw-agiledevelopment /list`

### 问题 3：收到 "Not available" 或错误信息

**原因**：扩展可能有加载问题

**解决方案**：

1. 打开 VS Code 的开发者工具：**Ctrl+Shift+I**（Windows/Linux）或 **Cmd+Shift+I**（Mac）
2. 查看 Console 标签中的错误信息
3. 检查扩展是否在"已安装"列表中
4. 尝试禁用并重新启用扩展

### 问题 4：无法列出技能或获取错误

**原因**：Copilot 模型加载中或网络连接问题

**解决方案**：

1. 检查网络连接
2. 等待 30 秒后重试
3. 确保 Copilot 订阅仍然有效
4. 尝试一个简单的查询：`@sw-agiledevelopment hello`

---

## 🔄 更新扩展

当有新版本发布时，VS Code 会自动通知你。

### 手动检查更新

1. 打开扩展面板（**Ctrl+Shift+X** 或 **Cmd+Shift+X**）
2. 搜索 "sw-agiledevelopment"
3. 如果有更新，会显示 "Update" 按钮，点击即可

---

## 📞 获取帮助

### 需要帮助？

1. **扩展不工作？** → 查看上面的"故障排查"部分
2. **不知道怎么用？** → 在 Copilot Chat 中问：
   ```
   @sw-agiledevelopment 怎么使用这个扩展？
   ```

3. **想学习具体的技能？** → 使用 `/skill` 命令：
   ```
   @sw-agiledevelopment /skill sw-technical-spec
   ```

4. **技术问题？** → 查看 [项目 GitHub](https://github.com/vaycent/sw-agiledevelopment)

---

## ✨ 开始使用

安装完成后，你就可以在 Copilot Chat 中使用 sw-agiledevelopment 的所有功能了！

### 推荐的第一步

```
在 Copilot Chat 中输入：
@sw-agiledevelopment /list
```

看看有哪些可用的开发技能！

---

**祝你使用愉快！** 🎉

有任何问题，可以随时询问 Copilot 或查看项目文档。
