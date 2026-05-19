# クロスフィット大塚 公式サイト

SEO構造要件定義書に基づいて静的HTMLで構築した、クロスフィット大塚のWebサイトです。

## ディレクトリ構成

```
/
├── index.html                    トップページ（LocalBusiness JSON-LD）
├── about.html                    初めての方へ
├── pricing.html                  料金・プラン（ドロップイン含む）
├── schedule.html                 レッスンスケジュール
├── facility.html                 施設紹介（設備・マシン・アメニティ）
├── coaches.html                  コーチ紹介（保有資格・経歴）
├── testimonials.html             メンバーの声
├── access.html                   アクセス（LocalBusiness JSON-LD）
├── trial.html                    体験レッスン申し込み（CVフォーム）
├── contact.html                  お問い合わせ
├── terms.html                    特定商取引法に基づく表記
├── privacy.html                  プライバシーポリシー
├── 404.html                      404エラーページ
├── blog/
│   ├── index.html                ブログトップ（カテゴリーサイロ）
│   ├── workout/
│   │   ├── index.html            カテゴリー：ワークアウト解説
│   │   └── 3-basic-movements-for-beginners.html
│   ├── nutrition/
│   │   ├── index.html            カテゴリー：食事・栄養
│   │   └── protein-timing-and-amount.html
│   ├── events/index.html         カテゴリー：イベント・コミュニティ
│   └── news/index.html           カテゴリー：お知らせ
├── assets/
│   ├── css/style.css             共通スタイルシート
│   └── img/
│       ├── logo.svg              ロゴ（プレースホルダー）
│       ├── og.svg                OG画像 1200x630（プレースホルダー）
│       └── coach-placeholder.svg コーチ写真プレースホルダー
├── favicon.svg                   ファビコン
├── sitemap.xml                   XMLサイトマップ（全19URL）
├── robots.txt                    クローラー制御
├── .htaccess                     HTTPS強制・URL正規化（Apache用）
├── scripts/
│   └── replace-placeholders.sh   本番化プレースホルダー一括置換
└── .github/workflows/
    └── site-check.yml            HTML/JSON-LD/リンクのCI検証
```

## 実装済みSEO要件チェックリスト

| 要件定義書セクション | 項目 | 状況 |
| --- | --- | --- |
| 2. サイトストラクチャ | サイトマップ全ページ | ✅ |
| 2. サイトストラクチャ | 3クリック以内到達 | ✅ グローバルナビ + フッターから全ページに1〜2クリック |
| 2.2 内部リンク | パンくずリスト | ✅ 全下層ページ |
| 2.2 内部リンク | ブログ→料金など関連リンク | ✅ |
| 3.1 HTML | h1各ページ1つ + 適切な階層 | ✅ |
| 3.1 HTML | alt属性 | ✅ 装飾画像はaria-label / 意味あるaltを記述 |
| 3.2 URL正規化 | HTTPS強制301 | ✅ `.htaccess` |
| 3.2 URL正規化 | www/index.html統合 | ✅ `.htaccess` |
| 3.2 URL正規化 | rel="canonical" | ✅ 全ページ |
| 3.3 クローラー | XMLサイトマップ | ✅ `sitemap.xml` |
| 3.3 クローラー | robots.txt | ✅ |
| 4.1 レスポンシブ | 単一URLでPC/SP対応 | ✅ |
| 4.2 LCP | 重い動画/未圧縮画像なし | ✅ SVG使用 |
| 4.2 LCP | フォント `display=swap` | ✅ |
| 4.2 CLS | 画像/動画の aspect-ratio / width-height | ✅ |
| 4.2 外部埋め込み非同期化 | Google Maps `loading="lazy"` | ✅ |
| 5.1 構造化データ | LocalBusiness (SportsActivityLocation) JSON-LD | ✅ トップ・アクセスページ |
| 5.1 構造化データ | BreadcrumbList JSON-LD | ✅ 全下層 |
| 5.1 構造化データ | BlogPosting JSON-LD | ✅ 記事ページ |
| 5.2 NAP統一 | テキストでフッター掲載 | ✅ |
| 6. E-E-A-T | コーチ独立ページ + 資格記載 | ✅ |
| 6. E-E-A-T | 監修者リンク from 記事 | ✅ |
| 6. E-E-A-T | フッターから法令ページ1クリック | ✅ |
| 7. CMS | メタデータ個別設定 | ✅ ページ毎title/description |
| 8. CVR | モバイル固定追従CTA | ✅ `.mobile-cta` |

### 検証結果（ローカル実行済み）

- **JSON-LD構文**: 24ブロックすべてパース成功
- **内部リンク**: 588リンクすべて到達可能（壊れリンクゼロ）

## ローカル確認

```bash
cd /path/to/crossfitotsuka
python3 -m http.server 8080
# http://localhost:8080/ にアクセス
```

## 本番化手順

### 1. プレースホルダー一括置換

`scripts/replace-placeholders.sh` で全ファイルの主要プレースホルダーを実値に置換できます。

```bash
PROD_DOMAIN="https://crossfit-otsuka.com" \
PROD_PHONE="+81-3-1234-5678" \
PROD_PHONE_DISPLAY="03-1234-5678" \
PROD_COMPANY="株式会社サンプル" \
PROD_REP="山田太郎" \
PROD_EMAIL="info@crossfit-otsuka.com" \
  bash scripts/replace-placeholders.sh
```

| 置換前（プレースホルダー） | 用途 | スクリプト変数 |
| --- | --- | --- |
| `https://crossfit-otsuka.example.com` | 本番ドメイン（canonical, JSON-LD, sitemap, OG） | `PROD_DOMAIN` |
| `+81-3-0000-0000` | JSON-LD `telephone` | `PROD_PHONE` |
| `03-0000-0000` | フッター・特商法・連絡ページの表示用電話番号 | `PROD_PHONE_DISPLAY` |
| `株式会社◯◯◯◯` | 特商法表記の事業者名 | `PROD_COMPANY` |
| `◯◯ ◯◯` | 特商法表記の運営責任者 | `PROD_REP` |
| `info@example.com` | 特商法表記のメールアドレス | `PROD_EMAIL` |

### 2. 残作業（手動）

実値が決まり次第、以下を更新してください。

- [ ] 大塚駅からの徒歩分数（`access.html` の「徒歩◯分」）
- [ ] 月会費・回数券・体験料金の数字（`pricing.html`, `trial.html`）
- [ ] 制定日（`privacy.html` の「2024年◯月◯日」）
- [ ] 月会員カード請求日（`terms.html` の「毎月◯日」）
- [ ] 体験申込フォーム / 問い合わせフォームの `action` 属性に送信先（Formspree, Netlify Forms, 自前API 等）
- [ ] 予約システム埋め込み（`schedule.html` のコメントアウト部分）
- [ ] 写真の差し替え（`assets/img/` のSVGプレースホルダーを実写JPEG/WebPに）
  - ロゴ：`logo.svg` → `logo.png`（推奨：512×512 PNG）
  - OG画像：`og.svg` → `og.jpg`（1200×630）
  - コーチ写真：`coach-placeholder.svg` → 個別の `coach-1.jpg` 等
- [ ] Googleビジネスプロフィールと、フッターNAPの**完全一致**を確認
- [ ] Google Search Console にサイト登録 + `sitemap.xml` 送信
- [ ] Google Analytics / Search Console 計測タグの設置（footer 直前に追加）

### 3. デプロイ

静的サイトホスティング先のおすすめ：

| サービス | 推奨理由 |
| --- | --- |
| **Cloudflare Pages** | 無料、高速、HTTPS/HTTP3自動、`.htaccess` の代替は `_redirects` を作成 |
| **Netlify** | 無料、フォーム機能あり（`trial.html` `contact.html` をそのまま使える）、`_redirects` 対応 |
| **Vercel** | 無料、高速。`vercel.json` でリダイレクトを設定 |
| **AWS S3 + CloudFront** | 既存AWS環境がある場合 |
| **既存レンタルサーバ（Apache）** | `.htaccess` がそのまま使える |

### 4. CMS化（将来計画）

要件書7章のWordPress化を行う場合は、本サイトのテンプレート・カテゴリーサイロ構造を維持して、ブログ部分のみWordPressに置き換える「ヘッドレスCMS構成」も選択肢です。

## CI

`.github/workflows/site-check.yml` が、`main` への push / PR で以下を検証します：

1. HTML構文（`html-validate`）
2. すべてのJSON-LDブロックがパース可能であること
3. 内部リンク切れがないこと（`linkinator`）

## ライセンス

社内利用。複製・再配布不可。
