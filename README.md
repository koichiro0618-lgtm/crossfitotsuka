# クロスフィット大塚 公式サイト

SEO構造要件定義書に基づき静的HTMLで構築した、クロスフィット大塚のコーポレートサイトです。

## ディレクトリ構成

```
/
├── index.html              トップページ（LocalBusiness JSON-LD）
├── about.html              初めての方へ
├── pricing.html            料金・プラン（ドロップイン含む）
├── schedule.html           レッスンスケジュール
├── facility.html           施設紹介（設備・マシン・アメニティ）
├── coaches.html            コーチ紹介（保有資格・経歴）
├── testimonials.html       メンバーの声
├── access.html             アクセス（LocalBusiness JSON-LD）
├── trial.html              体験レッスン申し込み（CVフォーム）
├── contact.html            お問い合わせ
├── terms.html              特定商取引法に基づく表記
├── privacy.html            プライバシーポリシー
├── blog/
│   └── index.html          ブログ・お知らせ（カテゴリーサイロ）
├── assets/
│   ├── css/style.css       共通スタイルシート
│   └── img/                画像（要：ロゴ、コーチ写真、OG画像）
├── sitemap.xml             XMLサイトマップ
├── robots.txt              クローラー制御
└── .htaccess               HTTPS強制・URL正規化（Apache用）
```

## 実装済みSEO要件

| 要件 | 実装状況 |
| --- | --- |
| サイト階層（3クリック以内） | ✅ グローバルナビ・フッターから全ページへ1〜2クリック |
| パンくずリスト + BreadcrumbList JSON-LD | ✅ 全下層ページ |
| `<h1>` 各ページ1つ・適切な階層 | ✅ |
| `alt` 属性 | ✅ |
| `rel="canonical"` | ✅ 全ページ |
| HTTPS強制 / `www`・`index.html` 統合 | ✅ `.htaccess` |
| LocalBusiness (SportsActivityLocation) JSON-LD | ✅ トップ・アクセスページ |
| NAP統一（テキスト・全ページ共通フッター） | ✅ |
| モバイル固定追従CTA | ✅ `.mobile-cta` |
| Core Web Vitals 配慮 | ✅ `aspect-ratio`、画像 `width/height`、`loading="lazy"`、フォント `display=swap` |
| 外部埋め込み非同期化 | ✅ Google Maps `loading="lazy"` |
| XMLサイトマップ・robots.txt | ✅ |
| E-E-A-T（コーチ独立ページ・運営情報） | ✅ |
| フッターからの法令ページ1クリック導線 | ✅ |
| OGP | ✅ |

## ローカル確認

任意のローカルWebサーバで起動できます。例：

```bash
python3 -m http.server 8080
# http://localhost:8080/ にアクセス
```

## 本番デプロイ前のTODO

- `https://crossfit-otsuka.example.com/` を実ドメインに置換（全HTML, sitemap.xml, JSON-LD）
- 電話番号 `03-0000-0000` を実番号に置換（JSON-LD `telephone` も）
- `assets/img/` にロゴ、コーチ写真、OG画像（WebP/JPEG）を配置
- フォーム `action` 属性をフォーム処理サービス（Formspree, Netlify Forms 等）または自前のエンドポイントに差し替え
- 体験レッスン料金、月会費等の数字を最新版に更新
- 特定商取引法表記の事業者名・運営責任者・メールアドレスを正式情報に置換
- Google Search Console にサイトマップを送信
- Googleビジネスプロフィールと NAP 完全一致を確認
- CMS化（WordPress 等）を行う場合は、ブログのカテゴリーサイロを維持する形でテーマ実装

## ライセンス

社内利用。複製・再配布不可。
