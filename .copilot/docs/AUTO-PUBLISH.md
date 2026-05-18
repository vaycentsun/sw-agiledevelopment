# 一键发布指南（GitHub Actions自动化）

## 🎯 零操作发布流程

只需3步：修改代码 → 更新版本 → git push 标签 → **自动发布到应用商店！**

## 📋 首次设置（仅需一次）

### 1. 获取 VS Code Marketplace Token

访问 https://marketplace.visualstudio.com/manage

1. 点击右上角头像
2. 选择 **Personal access tokens**
3. 点击 **New Token**，填写：
   - Name: `vscode-marketplace`
   - Organization: （留空）
   - Scopes: 勾选 **Manage**
4. 点击 **Create**，复制 token（后续无法再看到）

### 2. 添加 GitHub Secret

在你的 GitHub 仓库中：

1. 点击 **Settings** → **Secrets and variables** → **Actions**
2. 点击 **New repository secret**
3. 填写：
   - Name: `VSCODE_MARKETPLACE_TOKEN`
   - Secret: 粘贴上面复制的 token
4. 点击 **Add secret**

完成！现在 GitHub Actions 有权限自动发布了。

---

## 🚀 发布流程（每次只需这一步！）

### 情景 1：修复 Bug 或小改动

```bash
# 1. 修改代码（例如编辑 sw-*/SKILL.md）
# （自由编辑任何技能文件）

# 2. 更新版本号（package.json）
# 从 "1.2.4" 改为 "1.2.5"（patch 版本）

# 3. 提交并推送标签
git add .
git commit -m "Fix: improve debugging skill content"
git tag -a v1.2.5 -m "Release 1.2.5"
git push origin main --tags

# 完成！GitHub Actions 会自动：
# - 检测到 v1.2.5 标签
# - 自动打包扩展
# - 自动发布到应用商店
# - 发送邮件确认发布成功
```

### 情景 2：新增功能

```bash
# 1. 添加新技能或修改代码
# （例如新增 sw-example/ 目录和 SKILL.md）

# 2. 更新版本号（package.json）
# 从 "1.2.5" 改为 "1.3.0"（minor 版本）

# 3. 更新变更日志（可选）
# 编辑 CHANGELOG.md，添加新版本条目

# 4. 提交并推送标签
git add .
git commit -m "Feat: add new example skill"
git tag -a v1.3.0 -m "Release 1.3.0"
git push origin main --tags

# 自动发布开始！
```

---

## 📊 监控发布状态

发布后，可以查看自动化流程的运行状态：

### 方法 1：GitHub 网页查看

1. 打开你的 GitHub 仓库
2. 点击 **Actions** 选项卡
3. 看到 **Publish VS Code Extension** 工作流
4. 点击最新的运行记录查看日志

### 方法 2：实时邮件通知

- GitHub 会发送邮件通知发布成功或失败
- 点击邮件中的链接直接查看日志

---

## 🔄 更新流程总结

| 步骤 | 命令 | 自动化 |
|------|------|--------|
| 1. 编辑技能 | `vim sw-*/SKILL.md` | ❌ 手动 |
| 2. 本地测试 | `code .` + F5 | ❌ 手动 |
| 3. 更新版本 | 编辑 `package.json` | ❌ 手动 |
| 4. 提交代码 | `git add && git commit` | ❌ 手动 |
| 5. 推送标签 | `git tag && git push --tags` | ❌ 手动 |
| 6. 打包扩展 | ✅ 自动 | ✅ GitHub Actions |
| 7. 发布到商店 | ✅ 自动 | ✅ GitHub Actions |

---

## 💡 常用命令速查

### 完整发布流程（复制粘贴即用）

```bash
# 修改版本号后，一键发布：
git add .
git commit -m "Release v1.2.5: Fix something"
git tag -a v1.2.5 -m "Release 1.2.5"
git push origin main --tags
```

### 查看上次标签

```bash
git describe --tags
```

### 查看推送历史

```bash
git log --oneline --tags -n 10
```

---

## ⚠️ 注意事项

### 版本号必须匹配

发布前，**必须**确保 package.json 中的版本号与 git 标签版本号一致：

```bash
# ❌ 错误
git tag -a v1.2.5      # 标签
package.json: "version": "1.2.4"  # 不匹配！

# ✅ 正确
git tag -a v1.2.5      # 标签
package.json: "version": "1.2.5"  # 一致
```

### 标签格式要求

标签**必须**以 `v` 开头，后跟版本号：

```bash
✅ v1.0.0
✅ v1.2.5
❌ 1.2.5（没有 v 前缀）
❌ release-1.2.5
```

### 推送标签的正确方法

```bash
# 推送所有标签
git push origin main --tags

# 或推送单个标签
git push origin v1.2.5
```

---

## 🐛 故障排查

### 问题 1：发布失败 "401 Unauthorized"

原因：Token 无效或过期

解决：
1. 访问 https://marketplace.visualstudio.com/manage
2. 重新生成 token
3. 更新 GitHub Secret `VSCODE_MARKETPLACE_TOKEN`

### 问题 2：Actions 没有触发

原因：标签格式不对或没有推送标签

解决：
```bash
# 检查标签是否存在
git tag -l

# 重新创建标签（如果格式错了）
git tag -d v1.2.4  # 删除旧的
git tag -a v1.2.4 -m "Release 1.2.4"  # 创建新的
git push origin --tags  # 推送所有标签
```

### 问题 3：查看详细错误日志

1. 打开 GitHub 仓库 → **Actions** 选项卡
2. 找到最新的 **Publish VS Code Extension** 工作流
3. 点击进入查看详细日志

---

## 📈 发布历史

每次发布后，你可以查看：

- **应用商店链接**：https://marketplace.visualstudio.com/items?itemName=yourusername.sw-agiledevelopment
- **GitHub Releases**：https://github.com/yourusername/sw-agiledevelopment/releases
- **Actions 日志**：https://github.com/yourusername/sw-agiledevelopment/actions

---

## ✨ 就这么简单！

从现在开始，你的工作流就是：

```
编辑代码 → 提交 → git tag v1.x.x → git push --tags
                    ↓
              自动发布到应用商店！
```

享受自动化发布的便利！ 🎉
