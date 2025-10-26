# Next.js テンプレート

モダンなWebアプリケーション開発のためのNext.js 16テンプレート。TypeScript、TailwindCSS、ESLint、Prettier、Vitest、Storybook、Lefthookなど、開発に必要なツールが事前に設定されています。

## 特徴

- ⚡️ **Next.js 16** (App Router) + React 19 + TypeScript
- 🎨 **TailwindCSS 4** - 最新のユーティリティファーストCSS
- ✅ **ESLint + Prettier** - 自動フォーマット・リント設定済み
- 🧪 **Vitest + Testing Library** - 高速なユニットテスト
- 📚 **Storybook 9** - コンポーネント開発環境
- 🎣 **Lefthook** - Git hooks自動化（コミット前チェック）
- 🐳 **Docker** - コンテナ化された開発環境
- 🔍 **厳格なTypeScript設定** - 型安全な開発

## クイックスタート

### Dockerを使用する場合（推奨）

```bash
# コンテナ起動（初回はビルドに時間がかかります）
docker-compose up

# 開発サーバーが起動します
# http://localhost:3000 でアクセス可能

# Storybook起動（別ターミナル）
docker-compose exec app pnpm storybook
# http://localhost:6006 でアクセス可能

# コンテナ内でGit操作も可能
docker-compose exec app git status
docker-compose exec app git add .
docker-compose exec app git commit -m "feat: 新機能追加"
docker-compose exec app git push
```

**注意**: コンテナ内でGit操作を行う場合、ホストの `~/.ssh` と `~/.gitconfig` がマウントされます。SSH認証を使用してください。

### ローカル環境で使用する場合

```bash
# パッケージインストール
pnpm install

# lefthook初期化（Git hooksを有効化）
lefthook install

# 開発サーバー起動
pnpm dev

# Storybook起動
pnpm storybook
```

## 技術スタック

| カテゴリ                 | 技術                                  |
| ------------------------ | ------------------------------------- |
| **フレームワーク**       | Next.js 16, React 19, TypeScript 5    |
| **スタイリング**         | TailwindCSS 4, PostCSS                |
| **リント・フォーマット** | ESLint 9, Prettier 3                  |
| **テスト**               | Vitest 4, Testing Library, Playwright |
| **開発ツール**           | Storybook 9, Lefthook                 |
| **コンテナ**             | Docker, pnpm                          |

## 利用可能なスクリプト

```bash
# 開発
pnpm dev              # 開発サーバー起動
pnpm build            # プロダクションビルド
pnpm start            # プロダクションサーバー起動

# コード品質
pnpm lint             # ESLintチェック
pnpm lint:fix         # ESLint自動修正
pnpm format           # Prettierフォーマット
pnpm format:check     # Prettierチェック
pnpm check-types      # TypeScript型チェック

# テスト
pnpm test             # ユニットテスト実行
pnpm test:e2e         # E2Eテスト実行（Playwright）

# Storybook
pnpm storybook        # Storybook起動
pnpm build-storybook  # Storybookビルド
```

## 自動化されたコード品質チェック

### コミット前（pre-commit）

lefthookが以下を自動実行：

1. **Prettier** - 変更ファイルを自動フォーマット
2. **ESLint** - 変更ファイルを自動修正（import整理、Tailwindクラス並び替え等）
3. **コミットメッセージチェック** - `feat|fix|refactor|chore` で始まることを確認

### プッシュ前（pre-push）

以下のチェックをすべて通過しないとpushできません：

1. フォーマットチェック
2. リントチェック
3. TypeScript型チェック

## コミットメッセージ規約

以下のプレフィックスで始める必要があります：

```
feat: 新機能追加
fix: バグ修正
refactor: リファクタリング
chore: ビルド、設定変更など
```

## プロジェクト構成

```
.
├── app/                   # Next.js App Router
│   ├── layout.tsx        # ルートレイアウト
│   ├── page.tsx          # ホームページ
│   ├── page.test.tsx     # テスト
│   └── page.stories.tsx  # Storybook
├── .storybook/           # Storybook設定
├── public/               # 静的ファイル
├── lefthook.yml          # Git hooks設定
├── eslint.config.mjs     # ESLint設定
├── vitest.config.mts     # Vitest設定
├── tsconfig.json         # TypeScript設定
├── Dockerfile            # Dockerイメージ定義
└── docker-compose.yml    # Docker Compose設定
```

### Docker構成の詳細

- **ベースイメージ**: node:20-alpine
- **インストール済み**: git, openssh-client, pnpm, lefthook
- **ポート**: 3000 (Next.js), 6006 (Storybook)
- **マウント**:
  - ソースコード: `.:/app`
  - SSHキー: `~/.ssh/id_rsa:/root/.ssh/id_rsa:ro` (Git操作用)
  - Git設定: `~/.gitconfig:/root/.gitconfig:ro` (ユーザー情報)
  - pnpmキャッシュ: ボリュームで永続化

## 開発環境

### ESLintの自動修正機能

- **未使用import削除** - 自動的に削除されます
- **import順序整列** - React → external → internal → relative の順に自動整列
- **TailwindCSSクラス整列** - 統一された順序に自動整列
- **型import** - `import type` を強制

### TypeScript

- `type` を優先（`interface` は使用しない）
- `any` の使用は警告
- 厳格な型チェック有効

## トラブルシューティング

### lefthookが動作しない

```bash
# Docker内の場合
docker-compose exec app lefthook install

# ローカルの場合
lefthook install
```

### Git認証エラー（GitHub）

**Docker内でGit操作する場合**:

1. **SSH認証を使用**（推奨）:
   ```bash
   # リモートURLをSSHに変更
   git remote set-url origin git@github.com:USERNAME/REPO.git

   # SSHキーがホストに設定済みであれば、コンテナでも使用可能
   docker-compose exec app git push
   ```

2. **SSHキーの設定確認**:
   ```bash
   # ホストでSSHキーが存在するか確認
   ls -la ~/.ssh/id_rsa

   # GitHubにSSHキーが登録されているか確認
   ssh -T git@github.com
   ```

3. **SSHキーの作成**（未作成の場合）:
   ```bash
   # ホストマシンで実行
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

   # 公開鍵をGitHubに登録
   cat ~/.ssh/id_rsa.pub
   # https://github.com/settings/keys で登録
   ```

**ローカル環境の場合**:

HTTPS認証は非推奨のため、SSH認証に変更してください。

### ポートが使用中

開発サーバー（3000）やStorybook（6006）のポートが使用中の場合：

```bash
# プロセス確認
lsof -i :3000
lsof -i :6006

# または別ポートで起動
pnpm dev -- -p 3001
pnpm storybook -- -p 6007
```

## ライセンス

MIT

## 参考リンク

- [Next.js Documentation](https://nextjs.org/docs)
- [TailwindCSS Documentation](https://tailwindcss.com/docs)
- [Vitest Documentation](https://vitest.dev/)
- [Storybook Documentation](https://storybook.js.org/docs)
