# 要件定義
## 概要
 **一人一人違う好きなもの（ver.飲食店）** をランキング形式で投稿して共有するアプリ
## コンセプト
このアプリは、お気に入りの飲食店ベスト３をランキング形式で投稿し共有することができるアプリです。また、その個人のオリジナルランキングを集計した総合ランキングも見ることができます。

このアプリを開発した経緯は、作者自身がこれまで行ったことがない飲食店を探すときに使うアプリが欲しいと思っていた事と、プログラミングスクールで生徒が「お菓子の中で何が一番好きですか？」という話題で盛り上がっていた光景を目にしたことがアイデアの素となっています。  

個人個人違う好みが集まる場所を作れば、好きなことを通して誰かとつながる場所が提供でき、既存の幅広いユーザーに支持されているランキングにはなかなかランクインしないような、穴場な飲食店を発掘できるかもしれないと考えました。
それがこのアプリケーション、個人のランキング × 個人のランキング ＝ **Docking** になります。
## バージョン
Ruby 2.5.3  
Rails 5.2.2
## 機能一覧
- [x] ログイン機能
- [x] アカウント登録機能（名前, Email, パスワードは必須）
- [x] マイページ機能（カテゴリー毎に１〜３位までお気に入りの飲食店を登録できる）
- [x] ランキング一覧機能（総合ランキング、いいねランキング）
- [x] 検索機能
- [x] いいね機能
- [x] コメント機能
- [x] オートコンプリート機能
- [x] ハッシュタグ機能
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
