# 🚀 VS Code Extension 初始化指南

> **核心思路**：修改代码 → 推送 git 标签 → 自动发布到应用商店。无需任何额外步骤！

## 📋 首次初始化（5 分钟）

### 1️⃣ 创建 VS Code Marketplace 账户和 Token

1. 访问 https://marketplace.visualstudio.com/manage
2. 创建 Publisher（如果还没有）
   - 点击 **Create Publisher**
   - 填写名称（推荐与 GitHub 用户名一致）
   - 确认创建

3. 创建 Personal Access Token
   - 点击右上角头像
   - 选择 **Personal access tokens**
   - 点击 **New Token**
   - 填写：
     - **Name**: `vscode-publish`
     - **Organization**: （留空）
     - **Scopes**: 勾选 ✓ **Manage**
   - 点击 **Create**，**立即复制 token**（后续无法再看）

### 2️⃣ 在 GitHub 上配置自动化密钥

1. 打开你的 GitHub 仓库
2. 点击 **Settings** → **Secrets and variables** → **Actions**
3. 点击 **New repository secret**
4. 填写：
   - **Name**: `VSCODE_MARKETPLACE_TOKEN`
   - **Secret**: 粘贴上面复制的 token
5. 点击 **Add secret**

✅ 完成！现在 GitHub Actions 有权限自动发布了。

### 3️⃣ 验证 package.json 配置

打开 `package.json`，确认这些字段：

```json
{
  "name": "sw-agiledevelopment",
  "version": "1.2.4",
  "publisher": "vaycent",  // ← 改成你的 Publisher ID
  "displayName": "Agile Development - sw-agiledevelopment",
  "description": "Software development skills and workflows for coding with structured methodologies",
  ...
}
```

### 4️⃣ 推送首个版本（测试自动化）

```bash
cd /Users/vaycent/Documents/GitHub/sw-agiledevelopment

# 添加所有变更
git add .

# 提交
git commit -m "Setup VS Code extension auto-publishing"

# 创建版本标签（必须以 v 开头！）
git tag -a v1.2.4 -m "Release 1.2.4"

# 推送代码和标签
git push origin main --tags
```

### 5️⃣ 监控自动化过程

1. 打开 GitHub 仓库
2. 点击 **Actions** 选项卡
3. 看到 **Publish VS Code Extension** 工作流
4. 等待 2-5 分钟，绿色 ✅ 表示发布成功

🎉 完成！扩展已发布到应用商店。

---

## 🔄 之后每次发布

### 标准发布流程（3 步）

```bash
# 1️⃣ 编辑代码
vim sw-technical-spec/SKILL.md

# 2️⃣ 更新版本号（package.json）
# "version": "1.2.4" → "1.2.5"

# 3️⃣ 推送标签（一行命令）
git add . && \
git commit -m "Improve technical spec skill" && \
git tag -a v1.2.5 -m "Release 1.2.5" && \
git push origin main --tags
```

**就这样！** 自动发布开始，2-5 分钟后用户就能看到新版本。

### 快捷命令（复制粘贴）

```bash
# 查看当前版本
cat package.json | grep '"version"'

# 推送时的一行命令模板
git add . && git commit -m "Release notes here" && git tag -a v1.2.5 -m "Release 1.2.5" && git push origin main --tags
```

---

## 📊 检查发布状态

### 方式 1：GitHub 网页

```
仓库 → Actions → Publish VS Code Extension → 最新运行
```

### 方式 2：命令行

```bash
# 查看最新标签
git describe --tags

# 查看最近的提交
git log --oneline -5 --tags
```

### 方式 3：应用商店

发布成功后，访问：
```
https://marketplace.visualstudio.com/items?itemName=vaycent.sw-agiledevelopment
```

---

## 🐛 常见问题

### Q: Actions 没有触发？

**A:** 检查以下几点：

1. 标签格式是否正确？
   ```bash
   # ✅ 正确
   git tag -a v1.2.5 -m "Release 1.2.5"
   
   # ❌ 错误
   git tag -a 1.2.5          # 缺少 v 前缀
   git tag -a release-1.2.5  # 格式不对
   ```

2. 是否推送了标签？
   ```bash
   # 检查
   git tag -l | grep v1.2.5
   
   # 推送
   git push origin v1.2.5
   # 或推送所有标签
   git push origin --tags
   ```

### Q: Token 过期或无效？

**A:** 重新生成：

1. 访问 https://marketplace.visualstudio.com/manage
2. Personal access tokens → 删除旧的
3. 创建新的 token
4. 更新 GitHub Secret `VSCODE_MARKETPLACE_TOKEN`

### Q: 版本号提示不匹配？

**A:** 确保一致性：

```bash
# package.json 中
"version": "1.2.5"

# git 标签
git tag -a v1.2.5 -m "Release 1.2.5"
```

### Q: 如何撤销发布？

**A:** 删除标签并重新发布：

```bash
# 删除本地和远程标签
git tag -d v1.2.5
git push origin --delete v1.2.5

# 修复代码
# 重新创建标签
git tag -a v1.2.5-fixed -m "Release 1.2.5 fixed"
git push origin v1.2.5-fixed
```

---

## 📚 相关文件

| 文件 | 用途 |
|------|------|
| [PUBLISH.md](PUBLISH.md) | 发布快速参考 |
| [AUTO-PUBLISH.md](AUTO-PUBLISH.md) | 自动化详细说明 |
| [CHANGELOG.md](CHANGELOG.md) | 版本变更日志 |
| `.github/workflows/publish-extension.yml` | GitHub Actions 工作流定义 |

---

## ✨ 总结

你现在拥有一个**完全自动化的发布流程**：

```
修改代码
   ↓
git add . && git commit
   ↓
git tag && git push --tags
   ↓
GitHub Actions 自动打包、测试、发布
   ↓
用户在应用商店中下载最新版本 ✅
```

**从现在开始，你只需关心代码质量，发布交给 GitHub！** 🚀
