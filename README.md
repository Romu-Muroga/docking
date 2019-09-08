# Docking
![docking_top_page](https://user-images.githubusercontent.com/44666292/64483176-e98f6080-d238-11e9-97a4-dfa7b91bdc62.png)
## 概要
自分の好きなものをランキング形式で投稿して記録することができるアプリ（ver.飲食店）
## コンセプト
このアプリは、ランキングを大衆から個人へとフォーカスし、より人の好みが反映されているランキングを提供することを目的とした飲食店特化型のソーシャルメディアです。

このアプリを開発した経緯は、プログラミングスクールで生徒が「お菓子の中で何が一番好きですか？」という話で盛り上がっていた光景を目にしたことがアイデアのヒントとなっています。

大衆が選ぶランキングより、あの人が選ぶランキングを知りたいという声にお答えします。  
私の一番に出会える場所。それが、このアプリケーション。個人のランキング × 個人のランキング ＝ **Docking** となります。
## バージョン
![ruby version](https://img.shields.io/badge/Ruby-v2.5.3-blue.svg)
![rails version](https://img.shields.io/badge/Rails-v5.2.3-green)
![pstgresql version](https://img.shields.io/badge/PostgreSQL-v11.5-brightgreen)
## 機能一覧
- [x] ログイン
  - メールアドレス、パスワードを入力
- [x] アカウント登録
  - 名前、メールアドレス、パスワード、アイコン画像（任意）を入力
- [x] マイページ
  - 自分のお気に入りランキング
  - アカウント情報の管理（名前、メールアドレス、アイコン画像の変更／パスワード変更）
- [x] 投稿機能
  - カテゴリー毎に１〜３位までお気に入りの飲食店を投稿できる。
- [x] 投稿一覧
  - 全ユーザーの投稿一覧
  - 総合ランキング、いいね！ランキング
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
- rails_autolink
