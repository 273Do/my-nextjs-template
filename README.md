# Next.js の環境を構築するためのテンプレート

## 技術スタック

### フレームワーク・ライブラリ

- **Next.js**: 16.0.0 (App Router)
- **React**: 19.2.0
- **TypeScript**: 5.x

### スタイリング

- **TailwindCSS**: 4.x
- **PostCSS**: @tailwindcss/postcss

### コード品質

- **ESLint**: 9.x
  - @typescript-eslint/eslint-plugin
  - eslint-plugin-better-tailwindcss
  - eslint-plugin-import
  - eslint-plugin-react-hooks
  - eslint-plugin-react-refresh
  - eslint-plugin-unused-imports
- **Prettier**: 3.6.2

### テスト

- **Vitest**: 4.0.3
- **@testing-library/react**: 16.3.0
- **@testing-library/dom**: 10.4.1
- **jsdom**: 27.0.1

### Git Hooks

- **Lefthook**: Git hooksマネージャー

### コンテナ化

- **Docker**: node:20-alpine
- **pnpm**: パッケージマネージャー

## ディレクトリ構造

```
.
├── app/                      # Next.js App Router
│   ├── favicon.ico          # ファビコン
│   ├── globals.css          # グローバルCSS
│   ├── layout.tsx           # ルートレイアウト
│   ├── page.tsx             # ホームページ
│   ├── page.test.tsx        # ホームページのテスト
│   └── page.stories.tsx     # Storybook
├── public/                   # 静的ファイル
│   ├── file.svg
│   ├── globe.svg
│   ├── next.svg
│   ├── vercel.svg
│   └── window.svg
├── .gitignore               # Git除外設定
├── .prettierignore          # Prettier除外設定
├── .prettierrc              # Prettier設定
├── Dockerfile               # Dockerイメージ定義
├── docker-compose.yml       # Docker Compose設定
├── eslint.config.mjs        # ESLint設定
├── global.d.ts              # グローバル型定義
├── lefthook.yml             # Git hooks設定
├── next-env.d.ts            # Next.js型定義
├── next.config.ts           # Next.js設定
├── package.json             # パッケージ定義
├── postcss.config.mjs       # PostCSS設定
├── tsconfig.json            # TypeScript設定
├── vitest.config.mts        # Vitest設定
└── vitest.setup.ts          # Vitestセットアップ
```

## 設定ファイル詳細

### package.json

#### スクリプト

- `dev`: 開発サーバー起動
- `build`: プロダクションビルド
- `start`: プロダクションサーバー起動
- `lint`: ESLintチェック（修正なし）
- `lint:fix`: ESLintチェック＋自動修正
- `format`: Prettierでフォーマット
- `format:check`: Prettierチェック（修正なし）
- `check-types`: TypeScript型チェック
- `test`: Vitestでテスト実行

### tsconfig.json

主要な設定：

- `strict: true`: 厳格な型チェック
- `jsx: "react-jsx"`: React 19の新しいJSX変換
- `paths: { "@/*": ["./*"] }`: パスエイリアス設定
- `include`: グローバル型定義（global.d.ts）を含む

### eslint.config.mjs

#### 主要なルール

**TypeScript**:

- `@typescript-eslint/consistent-type-imports`: type importを強制
- `@typescript-eslint/consistent-type-definitions`: typeを優先（interfaceではなく）
- `@typescript-eslint/no-explicit-any`: any使用時に警告

**Import管理**:

- `unused-imports/no-unused-imports`: 未使用importを自動削除
- `import/order`: importを自動整列
  - Reactを最初
  - builtin/external → internal → parent/sibling/index
  - アルファベット順

**TailwindCSS**:

- `better-tailwindcss/enforce-consistent-class-order`: クラス順序を統一
- `better-tailwindcss/no-duplicate-classes`: 重複クラスを検出
- `better-tailwindcss/no-unregistered-classes`: 未登録クラスを検出

### lefthook.yml

#### pre-commit（コミット前）

並列実行で高速化：

- `format`: ステージングされたファイルをPrettierでフォーマット
- `lint-fix`: ステージングされたファイルをESLintで自動修正
- `stage_fixed: true`: 修正内容を自動でステージング

#### pre-push（プッシュ前）

- `format-check`: 全ファイルのフォーマットチェック
- `lint-check`: 全ファイルのリントチェック
- `type-check`: TypeScript型チェック

#### commit-msg（コミットメッセージ）

- コミットメッセージが `feat|fix|refactor|chore` で始まることを強制

### vitest.config.mts

- `environment: "jsdom"`: ブラウザ環境をシミュレート
- `setupFiles: ["./vitest.setup.ts"]`: jest-dom matchers を使用可能に
- `tsconfigPaths()`: tsconfig.jsonのパスエイリアスを認識
- `react()`: React Fast Refreshサポート

### Docker構成

#### Dockerfile

- ベースイメージ: node:20-alpine
- git, pnpm, lefthookをインストール
- ポート3000を公開

#### docker-compose.yml

- ボリュームマウント: ソースコードをリアルタイム反映
- 起動コマンド: `pnpm install && lefthook install && pnpm dev`
- ホットリロード対応: WATCHPACK_POLLING, CHOKIDAR_USEPOLLING

## 開発フロー

### 初回セットアップ

```bash
# Dockerコンテナ起動
docker-compose up -d

# コンテナ内でlefthook初期化（自動実行される）
# lefthook install
```

### 開発

```bash
# 開発サーバー起動（http://localhost:3000）
docker-compose up

# または、ホストマシンで
pnpm dev
```

### コミット前

lefthookが自動実行：

1. Prettierで自動フォーマット
2. ESLintで自動修正（import整理、Tailwindクラス並び替えなど）
3. コミットメッセージの形式チェック

### プッシュ前

lefthookが自動実行：

1. フォーマットチェック
2. リントチェック
3. 型チェック

すべて通過しないとpushできません。

### テスト

```bash
# テスト実行
pnpm test

# テストウォッチモード
pnpm test -- --watch
```

## コード規約

### コミットメッセージ

必ず以下のプレフィックスで始める：

- `feat:` 新機能追加
- `fix:` バグ修正
- `refactor:` リファクタリング
- `chore:` ビルド、設定変更など

例：

```
feat: ユーザー認証機能を追加
fix: ログイン時のバリデーションエラーを修正
refactor: API呼び出しロジックを整理
chore: ESLint設定を更新
```

### Import順序

ESLintが自動整列：

1. React関連
2. builtin/external（Node.js組み込み、npm パッケージ）
3. internal（プロジェクト内部モジュール）
4. parent/sibling/index（相対パス）

各グループ間に空行、アルファベット順。

### TailwindCSSクラス

ESLintが自動整列：

- 一貫した順序（improved order）
- 重複クラスは自動削除
- 未登録クラスは警告

### TypeScript

- `type` を優先（`interface` ではなく）
- type importは `import type` を使用
- `any` は警告（極力避ける）

## トラブルシューティング

### lefthookが動作しない

```bash
# Docker内で実行する場合
docker-compose exec app lefthook install

# ホストで実行する場合
lefthook install
```

### 型エラー: Cannot find module '\*.css'

`global.d.ts` に型定義を追加：

```typescript
declare module "*.css";
```

---

This is a [Next.js](https://nextjs.org) project bootstrapped with [`create-next-app`](https://nextjs.org/docs/app/api-reference/cli/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
# or
bun dev
```

Open [http://localhost:3000](http://localhost:3000) with your browser to see the result.

You can start editing the page by modifying `app/page.tsx`. The page auto-updates as you edit the file.

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.
