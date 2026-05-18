# VS Code Copilot Extension 发布管理

此目录包含 VS Code Copilot Chat Extension 的配置和文档。

## 📁 目录结构

```
.copilot/
├── INSTALL.md                        # 👈 🎯 用户安装指南（分享给用户和 AI Agent）
├── README.md                         # 此文件
├── STRUCTURE.md                      # 项目结构说明
├── docs/                             # VS Code 扩展相关文档（开发者文档）
│   ├── START-HERE.md                # 🚀 快速开始（首先阅读此文件）
│   ├── VSCODE-SETUP.md              # 📖 完整首次设置指南
│   ├── AUTO-PUBLISH.md              # 自动发布流程详细说明
│   ├── PUBLISH.md                   # 发布快速参考卡
│   ├── VSCODE-PUBLISH.md            # 发布指南（详细版）
│   ├── FIRST-PUBLISH.md             # 首次发布检查清单
│   └── QUICK-PUBLISH.md             # 5分钟快速发布指南
├── plugins/                          # OpenCode 插件（现有）
└── README.md                         # 此文件
```

## 🎯 快速导航

### 👥 用户安装

| 用途 | 文件 |
|------|------|
| **我要安装此扩展** | [`INSTALL.md`](INSTALL.md) 👈 **分享给 AI Agent** |
| **安装遇到问题** | [`INSTALL.md#⚠️-故障排查`](INSTALL.md#⚠️-故障排查) |

### 👨‍💻 开发者发布

| 场景 | 文件 |
|------|------|
| **我是第一次发布** | [`docs/START-HERE.md`](docs/START-HERE.md) |
| **我需要首次设置** | [`docs/VSCODE-SETUP.md`](docs/VSCODE-SETUP.md) |
| **我要发布新版本** | [`docs/PUBLISH.md`](docs/PUBLISH.md) |
| **我遇到发布问题** | [`docs/VSCODE-SETUP.md#-常见问题`](docs/VSCODE-SETUP.md#-常见问题) |
| **我需要完整自动化说明** | [`docs/AUTO-PUBLISH.md`](docs/AUTO-PUBLISH.md) |

## 🚀 30 秒快速安装（用户）

```bash
# 1. 在 VS Code 中按 Ctrl+Shift+X（或 Cmd+Shift+X on Mac）
# 2. 搜索 "sw-agiledevelopment"
# 3. 点击 Install
# 4. 重新加载 VS Code
# 5. 在 Copilot Chat 中输入：@sw-agiledevelopment /list

# 完成！开始使用吧 🎉
```

详细步骤见 → [`INSTALL.md`](INSTALL.md)

## 🚀 30 秒快速发布（开发者）

```bash
# 1. 修改代码
vim sw-technical-spec/SKILL.md

# 2. 更新版本（package.json）
# "1.2.4" → "1.2.5"

# 3. 推送标签
git add . && \
git commit -m "Improve skills" && \
git tag -a v1.2.5 -m "Release 1.2.5" && \
git push origin main --tags

# 完成！GitHub Actions 会自动发布
```

详细步骤见 → [`docs/PUBLISH.md`](docs/PUBLISH.md)

## 📋 首次发布检查清单

**（开发者首次发布前）**

```
[ ] 访问 https://marketplace.visualstudio.com/manage 生成 Token
[ ] 在 GitHub Settings → Secrets 添加 VSCODE_MARKETPLACE_TOKEN
[ ] 验证 package.json 中 publisher = "vaycent"
[ ] 推送首个标签测试自动化
[ ] 打开 GitHub → Actions 监控发布
```

详细步骤见 → [`docs/VSCODE-SETUP.md`](docs/VSCODE-SETUP.md)

## ✨ 工作流概览

```
【用户】
扩展市场搜索 → Install → 在 Copilot Chat 中使用 ✅

【开发者】  
修改代码 → git add . → git commit → git tag → git push --tags
                                                      ↓
                            GitHub Actions 自动打包和发布
                                                      ↓
                        用户在应用商店看到新版本 ✅
```

## 🔗 相关文件位置

| 文件 | 位置 | 用途 |
|------|------|------|
| GitHub Actions 工作流 | `.github/workflows/publish-extension.yml` | 自动发布配置 |
| VS Code 扩展代码 | `.vscode/extension.js` | Copilot Chat Participant 实现 |
| 扩展清单 | `package.json` | 扩展元数据和配置 |
| 打包配置 | `.vscodeignore` | 指定不打包的文件 |

## 📊 应用商店链接

发布成功后，用户可以通过以下链接下载：

```
https://marketplace.visualstudio.com/items?itemName=vaycent.sw-agiledevelopment
```

## 🎓 了解更多

- [VS Code Extension API](https://code.visualstudio.com/api)
- [VS Code Copilot Chat API](https://code.visualstudio.com/api/extension-guides/chat)
- [VSCE 工具](https://github.com/microsoft/vscode-vsce)
- [应用商店政策](https://marketplace.visualstudio.com/policies)

---

**👥 我是用户** → 打开 [`INSTALL.md`](INSTALL.md)  
**👨‍💻 我是开发者** → 打开 [`docs/START-HERE.md`](docs/START-HERE.md)
