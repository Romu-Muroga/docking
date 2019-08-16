# Docking
![top_page_screenshot](https://user-images.githubusercontent.com/44666292/63150251-471cfc80-c041-11e9-9694-62fdf4e81aec.png)
## 概要
自分の好きなものをランキング形式で投稿して記録することができるアプリ（ver.飲食店）
## コンセプト
このアプリは、ランキングを大衆から個人へフォーカスし、より信頼性の高いランキングを算出することを目的とした飲食店特化型のソーシャルメディアです。

このアプリを開発した経緯は、作者自身が飲食店を探すときに使うアプリが欲しいと思っていたことと、プログラミングスクールで生徒が「お菓子の中で何が一番好きですか？」という話で盛り上がっていた光景を目にしたことがアイデアの素となっています。  

ランキング形式にすることで、投稿者の嗜好が数値化され、性格分析のように味覚分析をして、自分と味の好みがマッチする人を見つけやすくなるのではないかと考えました。また、このアプリを訪れたユーザーは、架空のレストランへ来て本日のおすすめメニューを見ているような、そんな体験をすることもできます。  
それがこのアプリケーション、個人のランキング × 個人のランキング ＝ **Docking** となります。
## バージョン
![ruby version](https://img.shields.io/badge/Ruby-v2.5.3-blue.svg)
![rails version](https://img.shields.io/badge/Rails-v5.2.3-green)
![pstgresql version](https://img.shields.io/badge/PostgreSQL-v10.5-brightgreen)
## 機能一覧
- [x] ログイン機能
- [x] アカウント登録機能
  - 名前、メールアドレス、パスワード、アイコン
- [x] マイページ機能
  - 投稿一覧、アカウント情報の管理
- [x] 投稿機能
  - カテゴリー毎に１〜３位までお気に入りの飲食店を投稿できる。
- [x] ランキング一覧機能
  - 総合ランキング、いいねランキング
- [x] 検索機能
  - 所在地、店名、カテゴリー、順位で検索ができる。
- [x] いいね機能
- [x] コメント機能
  - 投稿記事にコメントができる。
- [x] オートコンプリート機能
- [x] ハッシュタグ機能
- [x] 管理者ユーザー機能
  - カテゴリーの管理、権限の管理、ユーザーの管理ができる。
## カタログ設計
https://docs.google.com/spreadsheets/d/1THV-ktLRUP-a33r23Mw0FJEcb4lcg9UZXu_xKWCgZ8Y/edit?usp=sharing
## テーブル定義
https://docs.google.com/spreadsheets/d/1THV-ktLRUP-a33r23Mw0FJEcb4lcg9UZXu_xKWCgZ8Y/edit?usp=sharing
## 画面遷移図
https://docs.google.com/spreadsheets/d/1THV-ktLRUP-a33r23Mw0FJEcb4lcg9UZXu_xKWCgZ8Y/edit?usp=sharing
## ER図
https://docs.google.com/presentation/d/1iyaylxcGwSXB2LC8BbA8XI3CQqI_8TBPcEKiv_VoNJU/edit?usp=sharing
## ワイヤーフレーム
#### ランキング一覧画面
https://cacoo.com/diagrams/qzbpgYsOZwdL6hjK/88193
#### マイページ画面
https://cacoo.com/diagrams/qzbpgYsOZwdL6hjK/63E3F
#### アカウント登録・編集、ログイン、退会処理画面
https://cacoo.com/diagrams/qzbpgYsOZwdL6hjK/6DA5F
#### コメント投稿画面
https://cacoo.com/diagrams/qzbpgYsOZwdL6hjK/2DB02
#### ランキング新規登録画面及び編集画面
https://cacoo.com/diagrams/qzbpgYsOZwdL6hjK/02A72
## 使用Gem
- counter_culture
- carrierwave
- jquery-rails
- jquery-ui-rails
- mini_magick
- rails-jquery-autocomplete
- ransack
