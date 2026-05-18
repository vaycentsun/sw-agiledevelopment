# sw-agiledevelopment VS Code Extension 发布指南

## 前置要求

1. **VS Code Extension 账户**
   - 访问 https://marketplace.visualstudio.com/manage
   - 创建 Personal Access Token (PAT)
   - 记下你的 Publisher ID

2. **安装工具**
   ```bash
   npm install -g @vscode/vsce
   ```

3. **更新 package.json**
   - `publisher` 字段：设置为你的 Publisher ID
   - `version`：每次发布前需要递增

## 本地测试

### 1. 安装依赖（可选，仅用于类型检查）
```bash
npm install --save-dev @types/vscode
```

### 2. 测试扩展
```bash
# 在 VS Code 中打开此项目文件夹
code .

# 按 F5 启动调试会话
# 这会打开一个新的 VS Code 窗口，扩展已加载

# 在新窗口的 Copilot Chat 中输入：
# @sw-agiledevelopment /list
```

## 打包扩展

```bash
# 1. 登录到发布账户
vsce login yourusername

# 2. 打包扩展为 .vsix 文件
vsce package

# 此命令会生成 sw-agiledevelopment-x.x.x.vsix 文件
```

## 发布到应用商店

### 方案 A：完全自主发布（推荐）

```bash
# 1. 升级版本号
# 编辑 package.json 中的 version 字段

# 2. 发布
vsce publish

# 该命令会：
# - 打包扩展
# - 上传到 VS Code 应用商店
# - 自动生成发布链接

# 3. 发布链接格式
https://marketplace.visualstudio.com/items?itemName=yourusername.sw-agiledevelopment
```

### 方案 B：手动上传 .vsix 文件

1. 打包：`vsce package`
2. 访问 https://marketplace.visualstudio.com/manage
3. 选择你的扩展
4. 手动上传 .vsix 文件

## 版本管理

### 遵循语义化版本 (SemVer)：

- **MAJOR** (1.0.0 → 2.0.0)：不兼容的 API 改动
- **MINOR** (1.0.0 → 1.1.0)：新增技能或功能
- **PATCH** (1.0.0 → 1.0.1)：bug 修复

### 发布前检查清单

- [ ] 更新 `package.json` 版本号
- [ ] 在 CHANGELOG.md 中记录变更
- [ ] 运行本地测试（按 F5）
- [ ] 验证 `/list` 和 `/skill` 命令正常
- [ ] 验证所有技能文件可访问
- [ ] 提交 git 变更：`git add -A && git commit -m "Bump version to x.x.x"`
- [ ] 创建 git tag：`git tag -a vx.x.x -m "Release x.x.x"`

## 现有结构保护

此发布方案的优点：

✅ 不修改任何现有的 `sw-*/SKILL.md` 文件
✅ 不破坏 OpenCode 或 Codex 适配
✅ 新增 VS Code 支持而不是替换
✅ 可同时维护多个平台的适配

## Copilot Chat 中的用户体验

用户安装此扩展后，可以：

```
用户：@sw-agiledevelopment /list
Assistant: 列出所有可用技能

用户：@sw-agiledevelopment /skill sw-technical-spec
Assistant: 显示详细的技术规格编写指南

用户：@sw-agiledevelopment 我需要编写技术规格
Assistant: 搜索并推荐相关技能
```

## 常见问题

### Q1：能否将扩展发布到官方 GitHub 账户？
A: 可以，但需要 GitHub 官方授权。目前建议个人账户发布。

### Q2：如何更新已发布的扩展？
A: 
1. 在本地更新代码
2. 更新 package.json 版本号
3. 运行 `vsce publish` 重新发布

### Q3：用户如何安装？
A: 在 VS Code 中：
- 打开扩展市场 (Ctrl+Shift+X / Cmd+Shift+X)
- 搜索 "sw-agiledevelopment"
- 点击安装

### Q4：能否支持自定义技能加载？
A: 可以，后续版本可添加 `skillsPaths` 配置选项。

## 后续优化

- [ ] 添加配置项支持自定义技能路径
- [ ] 创建 Side Panel UI 展示技能详情和搜索
- [ ] 支持技能版本控制
- [ ] 添加多语言支持
- [ ] 集成技能评分和用户反馈
