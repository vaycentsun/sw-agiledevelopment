# 🚀 首次发布检查清单（5分钟完成）

## ✅ 步骤 1：在 GitHub 上配置 Secret

```
[ ] 打开你的 GitHub 仓库
[ ] 点击 Settings → Secrets and variables → Actions
[ ] 创建新 Secret：
    名称：VSCODE_MARKETPLACE_TOKEN
    值：从 https://marketplace.visualstudio.com/manage 生成的 token
```

详细步骤见 [AUTO-PUBLISH.md](AUTO-PUBLISH.md#-首次设置仅需一次)

## ✅ 步骤 2：更新 package.json

打开 `package.json`，修改 `publisher` 字段为你的用户名：

```json
{
  "publisher": "yourusername",  // ← 改成你的 GitHub 用户名或 VS Code Publisher ID
  "name": "sw-agiledevelopment",
  "displayName": "Agile Development - sw-agiledevelopment",
  ...
}
```

## ✅ 步骤 3：推送首个版本

```bash
git add .
git commit -m "Initial VS Code extension setup"
git tag -a v1.2.4 -m "Release 1.2.4"
git push origin main --tags
```

## ✅ 步骤 4：监控发布

1. 打开你的 GitHub 仓库
2. 点击 **Actions** 选项卡
3. 看到 **Publish VS Code Extension** 工作流运行

等待 2-5 分钟，扩展会自动发布到应用商店！

---

## 📝 之后每次发布只需

```bash
# 1. 修改技能或代码
vim sw-*/SKILL.md

# 2. 更新版本号
# 编辑 package.json 中的 version 字段

# 3. 一行命令推送
git add . && git commit -m "v1.2.5 release" && git tag -a v1.2.5 -m "Release 1.2.5" && git push origin main --tags
```

完成！ 🎉 自动发布开始。

---

## 🔗 发布后的链接

发布成功后，用户可以通过以下链接下载：

```
https://marketplace.visualstudio.com/items?itemName=yourusername.sw-agiledevelopment
```

---

## ❓ 遇到问题？

- Actions 没有触发？检查标签格式是否为 `v1.2.x`
- 发布失败？查看 Actions 日志
- Token 过期？重新生成并更新 GitHub Secret

详见 [AUTO-PUBLISH.md](AUTO-PUBLISH.md#-故障排查)
