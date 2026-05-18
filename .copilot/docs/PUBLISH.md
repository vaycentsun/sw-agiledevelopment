# 📌 快速参考：一键发布

## 🎯 发布流程（复制粘贴）

### 第一次发布前

```bash
# 1. 打开 GitHub → Settings → Secrets and variables → Actions
# 2. 创建 Secret：VSCODE_MARKETPLACE_TOKEN = (你的 token)
# 3. 确认 package.json 中的 publisher = "vaycent"
# 完成！
```

### 每次发布

```bash
# 修改代码和版本号后，运行这个命令：
git add . && git commit -m "v1.2.5: your message" && git tag -a v1.2.5 -m "Release 1.2.5" && git push origin main --tags
```

然后等 5 分钟，GitHub Actions 会自动发布！

## 📊 发布状态查看

```
GitHub → Actions → 最新的 "Publish VS Code Extension" 工作流
```

## 🔗 发布后用户访问链接

```
https://marketplace.visualstudio.com/items?itemName=vaycent.sw-agiledevelopment
```

---

## 版本号更新规则

| 情况 | 更新方式 | 示例 |
|------|--------|------|
| 修复 bug 或小改动 | Patch | 1.2.4 → 1.2.5 |
| 新增功能（新技能）| Minor | 1.2.5 → 1.3.0 |
| 大改或重构 | Major | 1.3.0 → 2.0.0 |

---

## ⚡ 完整命令一覧

```bash
# 查看当前版本
grep '"version"' package.json

# 查看最新标签
git describe --tags

# 查看所有标签
git tag -l | sort -V

# 删除错误的标签（本地）
git tag -d v1.2.4

# 删除错误的标签（远程）
git push origin --delete v1.2.4

# 查看 Actions 日志
# 直接打开浏览器访问：https://github.com/yourusername/sw-agiledevelopment/actions
```

---

## ✅ 完整工作流示例

```bash
# 1. 编辑 sw-technical-spec/SKILL.md（或其他文件）
vim sw-technical-spec/SKILL.md

# 2. 在 package.json 中更新版本号
# "version": "1.2.4" → "1.2.5"

# 3. 提交并推送标签（一行命令）
git add . && git commit -m "Improve technical spec skill" && git tag -a v1.2.5 -m "Release 1.2.5" && git push origin main --tags

# 完成！GitHub Actions 会在 2-5 分钟内自动发布
```

就这么简单！🎉
