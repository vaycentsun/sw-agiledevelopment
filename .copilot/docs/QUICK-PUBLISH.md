# 一步步发布到 VS Code 应用商店

## 📋 发布前检查清单

```
[ ] 在 package.json 中更新 "publisher" 为你的 Publisher ID
[ ] 在 package.json 中更新 "version" 字段（遵循 SemVer）
[ ] 在 CHANGELOG.md 中记录本次变更
[ ] 本地测试：按 F5 调试，在 Copilot Chat 中运行 @sw-agiledevelopment /list
[ ] 提交代码：git add -A && git commit -m "Release v1.x.x"
```

## ⚡ 5 分钟快速发布指南

### 第 1 步：获取发布权限（首次设置）

```bash
# 1. 访问 https://marketplace.visualstudio.com/manage
# 2. 点击 "Create Publisher"，填写发布者名称
# 3. 点击用户头像，选择 "Personal access tokens"
# 4. 创建新的 PAT，选择 "Manage" 权限，复制 token

# 5. 登录到本地（first-time only）
vsce login <publisher-name>
# 粘贴上面复制的 token
```

### 第 2 步：准备发布

```bash
# 1. 进入项目目录
cd /Users/vaycent/Documents/GitHub/sw-agiledevelopment

# 2. 更新版本号（修改 package.json）
# 从 "1.2.4" 改为 "1.2.5"（patch 版本）

# 3. 提交变更
git add package.json CHANGELOG.md
git commit -m "Bump version to 1.2.5"
git tag -a v1.2.5 -m "Release 1.2.5"
```

### 第 3 步：发布

```bash
# 一行命令发布到应用商店
vsce publish

# 或者手动分两步
vsce package              # 生成 .vsix 文件
vsce publish              # 上传到应用商店
```

### 第 4 步：验证发布成功

- 访问 `https://marketplace.visualstudio.com/items?itemName=<publisher-name>.sw-agiledevelopment`
- 应该能看到你的扩展页面

## 🔍 测试清单（发布前必做）

在 VS Code 中按 **F5** 启动调试会话，然后测试：

```
输入                                   预期结果
--------------------------------------------
@sw-agiledevelopment /list            列出所有 sw-* 技能

@sw-agiledevelopment /skill           显示使用说明
  sw-technical-spec

@sw-agiledevelopment /skill           显示特定技能内容
  testing-driven-dev

@sw-agiledevelopment how to debug     自动推荐相关技能
```

## 📦 创建新版本的完整流程

### 情景：修复 bug 或添加新功能

```bash
# 1. 编辑技能或代码
# 编辑 sw-*/SKILL.md 或 .vscode/extension.js

# 2. 测试（按 F5）
# 验证改动在 Copilot Chat 中正常工作

# 3. 更新版本和日志
# 修改：
#   - package.json: version: "1.2.4" → "1.2.5"
#   - CHANGELOG.md: 添加 [1.2.5] 条目

# 4. 提交和发布
git add .
git commit -m "Fix: improve skill loading"
git tag -a v1.2.5 -m "Release 1.2.5"

# 5. 上传到应用商店
vsce publish

# 6. 完成！
# 用户会在 24 小时内看到更新
```

## 🎯 版本号规则

| 情况 | 版本更新 | 示例 |
|------|--------|------|
| 新增技能 | Minor | 1.2.4 → 1.3.0 |
| 修复 bug | Patch | 1.2.4 → 1.2.5 |
| 大改重构 | Major | 1.2.4 → 2.0.0 |

## 💡 如何修改 Publisher ID

**当前配置：**

```json
// package.json
{
  "publisher": "vaycent"
}
```

**改为你的 ID：**

1. 访问 https://marketplace.visualstudio.com/manage
2. 查看 Publisher Name（例如 "myteam"）
3. 编辑 package.json：`"publisher": "myteam"`
4. 现在发布链接会是 `https://marketplace.visualstudio.com/items?itemName=myteam.sw-agiledevelopment`

## ❓ 常见问题

### Q: 发布失败说 "401 Unauthorized"？
A: 检查 token 是否过期，重新运行 `vsce login <publisher-name>`

### Q: 发布后多久用户能看到？
A: 通常 5-15 分钟，最多 24 小时

### Q: 已发布的版本能否删除？
A: 可以，但建议用新版本替代，而不是删除旧版本

### Q: 如何让用户自动更新？
A: VS Code 会自动检查并提示用户更新（可配置）

## 🚀 发布成功后

1. **在 GitHub 上创建 Release**
   ```bash
   git push origin main --tags
   ```

2. **更新 README.md**
   - 添加安装说明
   - 添加 VS Code Marketplace 徽章

3. **社区推广**
   - 分享到开发社区
   - 提交到 awesome-lists

## 📞 需要帮助？

- VS Code Extension API 文档：https://code.visualstudio.com/api
- VSCE 工具文档：https://github.com/microsoft/vscode-vsce
- Marketplace 政策：https://marketplace.visualstudio.com/policies
