# 要件定義
## 概要
 **一人一人違う好きなもの（ver.飲食店）** をランキング形式で投稿して共有するアプリ
## コンセプト
このアプリは、自分のお気に入りの飲食店をランキング形式で投稿し共有することができるオリジナルランキングアプリです。また、その個人のオリジナルランキングを集計した総合ランキングも見ることができます。

このアプリを開発した経緯は、作者自身がこれまで行ったことがない飲食店を新規開拓するときに使うアプリが欲しいと思っていた事と、プログラミングスクールに通っていた時、休憩中に生徒が「お菓子の中で何が一番好きですか？」という話題で楽しそうに話していた光景を目にしたことがアイデアの素となっています。  

個人個人違う好みが集まる場所を作れば、プログラミングスクールで目にした自分の好きなことを人と共有する場所が提供でき、作者のような既存の幅広いユーザーに支持されているランキングではなかなか出会うことができないような、ローカルな飲食店を発掘できるかもしれないと考えました。
それがこのアプリケーション、個人のランキング × 個人のランキング ＝ **docking** になります。
## バージョン
RUby 2.5.3  
Rails 5.2.2
## 機能一覧
- [ ] ログイン機能
- [ ] アカウント登録機能（名前, Email, パスワードは必須）
- [ ] マイページ機能（カテゴリー毎に３位までのお気に入りの飲食店ランキングを登録できる）
- [ ] ランキング一覧機能（総合ランキング、いいねランキング、検索機能）
- [ ] いいね機能
- [ ] コメント機能
- [ ] ハッシュタグ機能
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
- jquery-rails
- jquery-ui-rails
- rails-jquery-autocomplete
- counter_culture
- carrierwave
- mini_magick
