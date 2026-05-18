# 🎯 VS Code Extension 自动发布 — 快速开始

## 你现在拥有的

✅ **完全自动化的发布系统**：修改代码 → git push 标签 → 自动发布到应用商店

✅ **零复杂度**：不需要本地构建、测试或手动上传文件

✅ **保护现有结构**：不破坏 OpenCode、Codex 的任何配置

## 🚀 首次使用（3 步）

### 1️⃣ 配置 GitHub Secret

```bash
# 1. 访问 https://marketplace.visualstudio.com/manage
# 2. 生成 Personal Access Token（Scopes: Manage）
# 3. 在 GitHub 仓库 Settings → Secrets and variables → Actions
# 4. 新增 Secret: VSCODE_MARKETPLACE_TOKEN = (你的 token)
```

✅ 需要 5 分钟一次性设置

### 2️⃣ 验证 publisher 字段

打开 `package.json`，确认：
```json
"publisher": "vaycent"  // ← 你的 Publisher ID
```

### 3️⃣ 测试自动化（推送首个标签）

```bash
git add . && \
git commit -m "Setup VS Code extension" && \
git tag -a v1.2.4 -m "Release 1.2.4" && \
git push origin main --tags
```

然后查看 GitHub → **Actions** → 等待 ✅ 完成

---

## 📝 每次发布（30 秒）

```bash
# 1. 修改代码
vim sw-technical-spec/SKILL.md

# 2. 更新版本号（package.json）
# 从 1.2.4 → 1.2.5

# 3. 推送标签
git add . && \
git commit -m "Improve skills" && \
git tag -a v1.2.5 -m "Release 1.2.5" && \
git push origin main --tags

# 完成！自动发布 2-5 分钟内完成
```

---

## 📊 监控发布

```
GitHub 仓库 → Actions 选项卡 → "Publish VS Code Extension" 工作流
```

---

## 🔗 用户访问链接

```
https://marketplace.visualstudio.com/items?itemName=vaycent.sw-agiledevelopment
```

---

## 📚 详细文档

| 需要什么 | 查看文件 |
|--------|--------|
| 完整首次设置指南 | [VSCODE-SETUP.md](VSCODE-SETUP.md) |
| 发布快速参考 | [PUBLISH.md](PUBLISH.md) |
| 自动化详细说明 | [AUTO-PUBLISH.md](AUTO-PUBLISH.md) |
| 故障排查 | [VSCODE-SETUP.md#-常见问题](VSCODE-SETUP.md#-常见问题) |

---

## ⚡ 命令速查

```bash
# 查看当前版本
grep version package.json

# 查看最新标签
git describe --tags

# 推送所有标签
git push origin --tags

# 查看 Actions 日志
# 直接打开 GitHub → Actions
```

---

## ✨ 就这样！

从现在开始，你的工作流就是：

```
修改代码 → 更新版本 → git tag → git push --tags → 🎉 自动发布完成
```

**享受自动化发布的自由！** 🚀
