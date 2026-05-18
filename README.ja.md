<div align="right">
  <a href="./README.md">🇺🇸 English</a> | <a href="./README.zh.md">🇨🇳 中文</a> | <strong>🇯🇵 日本語</strong> | <a href="./README.es.md">🇪🇸 Español</a> | <a href="./README.fr.md">🇫🇷 Français</a>
</div>

# sw-agiledevelopment 🦸

> AI コーディングエージェント向けの Agile Development スキルセット — 要件分析からコードレビューまでの構造化されたソフトウェアエンジニアリングワークフロー。

AI コーディングエージェントが、体系的かつ再現性のある方法で要件分析からコードレビューまでの各ステップを完了するのを支援する、完全なソフトウェアエンジニアリングワークフロースキルセットです。

**マルチプラットフォーム対応**：本フレームワークは **OpenCode**（プラグイン、推奨）、**Codex**（プラグイン）、**GitHub Copilot**（スキルモード）をネイティブにサポートしています。お好みの AI Agent プラットフォームを選び、以下のインストールガイドに従ってください。

---

## 🚀 クイックスタート

### インストール

**OpenCode プラグイン（推奨）**

AI Agent に以下のように伝えてください：

> "https://github.com/vaycentsun/sw-agiledevelopment から sw-agiledevelopment プラグインをインストールし、`.opencode/INSTALL.md` の手順に従ってください。"

Agent がインストールガイドを読み取り、プラグインを設定し、インストールを自動的に検証します。

**Codex プラグインインストール**

AI Agent に以下のように伝えてください：

> "https://github.com/vaycentsun/sw-agiledevelopment から sw-agiledevelopment プラグインをインストールし、`.codex-plugin/INSTALL.md` の手順に従ってください。"

Agent がインストールガイドを読み取り、プラグインを設定し、インストールを自動的に検証します。

**GitHub Copilot（スキルモード）**

AI Agent に以下のように伝えてください：

> "https://github.com/vaycentsun/sw-agiledevelopment から sw-agiledevelopment Copilot skill をインストールし、`.github/INSTALL.md` の手順に従ってください。"

Agent は以下を実行します：
1. `.github/copilot-instructions.md` をあなたのプロジェクトの `.github/` ディレクトリにコピーします（Copilot はすべての Chat セッションで自動的に読み取ります）
2. すべての `sw-*/` スキルディレクトリをあなたのプロジェクトの `.sw-agiledevelopment/` ディレクトリにコピーします（詳細な参照用）

Marketplace token や VSIX インストールは不要です。インストール後、Copilot は自動的にアジャイル開発ワークフローに従います。

**Android Studio（AI Agent）**

AI Agent に以下のように伝えてください：

> "https://github.com/vaycentsun/sw-agiledevelopment から sw-agiledevelopment フレームワークをインストールし、`.androidstudio/INSTALL.md` の手順に従ってください。"

Agent は以下を実行します：
1. `.androidstudio/sw-agiledevelopment.md` をあなたのプロジェクトの `.androidstudio/` ディレクトリにコピーします（Android Studio AI Agent はこれを system prompt として読み取ります）
2. すべての `sw-*/` スキルディレクトリをあなたのプロジェクトの `.sw-agiledevelopment/` ディレクトリにコピーします（詳細な参照用）

プラグインのインストールは不要です。インストール後、Android Studio AI Agent は自動的にアジャイル開発ワークフローに従います。

---

## 🗺️ コアワークフロー

```
新機能の開始
    ↓
sw-requirements-clarification (要件分析と設計)
    ↓ 出力: business-specs/YYYY-MM-DD--feature.md
sw-technical-spec (技術仕様書の作成)
    ↓ 出力: technical-specs/YYYY-MM-DD--feature.md
sw-working-plan (実装計画の作成)
    ↓ 出力: plans/YYYY-MM-DD--feature-plan.md
sw-subagent-development (サブエージェント駆動開発)
    ├── sw-test-driven-dev (各タスクの TDD)
    ├── sw-code-review (タスク後のレビュー)
    ↓
sw-task-verification (タスク検証)
    ↓
sw-finishing-branch (ブランチ完了)
```

**代替パス：**
- `sw-execute-plan` — 同じセッションで計画をバッチ実行（サブエージェント不使用）
- `sw-parallel-debugging` — 複数の独立した失敗を並列デバッグ

---

## 📝 TODO

- **TODO**: 可視化要件分析を統合し、requirements-clarification（要件分析）段階の前に要件分析と文書作成を強化する。

---

## 📋 スキル一覧

| スキル | 目的 | トリガー条件 |
|-------|------|-------------|
| **sw-requirements-clarification** | アイデアを要件に変換 | 新機能開発の開始 |
| **sw-technical-spec** | 構造化された技術仕様を作成 | 要件が明確化された |
| **sw-working-plan** | 詳細な実装計画を作成 | 実行計画が必要 |
| **sw-subagent-development** | サブエージェントを使用して計画を実行 | タスクが独立している |
| **sw-execute-plan** | 同じセッションで計画をバッチ実行 | サブエージェント不使用 |
| **sw-test-driven-dev** | RED-GREEN-REFACTOR サイクルを強制 | 機能実装またはバグ修正 |
| **sw-code-review** | コードレビューの依頼と対応 | タスク完了後、マージ前 |
| **sw-systematic-debugging** | 体系的なバグ調査 | バグ発見またはテスト失敗 |
| **sw-parallel-debugging** | 並列デバッグ | 2+ 独立した失敗 |
| **sw-task-verification** | タスク完了の検証 | タスクを完了としてマークする準備完了 |
| **sw-finishing-branch** | 検証、判断、ブランチのクリーンアップ | すべてのタスクが完了 |
| **sw-writing-skills** | 新しいスキルを作成・検証 | 新しいスキルの作成が必要 |
| **sw-using-agiledevelopment** | スキルシステムブートストラップ | すべての会話の開始時 |

---

## 📄 ライセンス

[MIT](./LICENSE)

---

## 🙏 謝辞

- Agile Development 方法论に基づき、[Superpowers](https://github.com/anthropics/superpowers) スキル形式からインスピレーションを得た
- 熟成されたソフトウェアエンジニアリングの実践にインスパイアされた
