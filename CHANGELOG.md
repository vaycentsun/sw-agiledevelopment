# Changelog

All notable changes to the sw-agiledevelopment VS Code extension will be documented in this file.

## [1.2.4] - 2025-05-18

### Added
- Initial VS Code Copilot Chat Extension support
- Chat Participant `@sw-agiledevelopment` with commands: `/list`, `/skill`
- Automatic skill discovery from `sw-*` directories
- Natural language skill search and recommendation
- Side-by-side compatibility with OpenCode and Codex adaptations
- GitHub Actions automatic publishing workflow
- Complete documentation in [`.copilot/docs/`](.copilot/docs/)

### Features
- **List Skills**: `/list` command shows all available development skills
- **Skill Guidance**: `/skill <name>` loads detailed skill content
- **Smart Search**: Automatically matches natural language queries to relevant skills
- **Auto-Publishing**: Push git tags to automatically publish to VS Code Marketplace
- **No Breaking Changes**: Existing OpenCode/Codex adaptations remain fully functional

### How to Get Started
1. Read [`.copilot/docs/START-HERE.md`](.copilot/docs/START-HERE.md) for setup instructions
2. Follow [`.copilot/docs/VSCODE-SETUP.md`](.copilot/docs/VSCODE-SETUP.md) for first-time configuration
3. Use git tags to publish: `git tag -a v1.2.4 -m "Release 1.2.4" && git push origin main --tags`

### How Users Install
1. Search for "sw-agiledevelopment" in VS Code Extensions Marketplace
2. Click Install
3. Use `@sw-agiledevelopment /list` in Copilot Chat

## [1.2.6] - 2026-05-18

### Changed
- Upgrade Node.js version to 20 in publish workflow

## [Unreleased]

### Planned Features
- [ ] Custom skill paths configuration
- [ ] Side Panel UI for skill browser
- [ ] Skill rating and user feedback
- [ ] Multi-language support (currently Chinese/English docs)
- [ ] Skill execution templates
- [ ] Integration with VS Code tasks for workflow execution
