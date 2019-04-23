# 要件定義
## 概要
「自分だけが気に入っているオリジナルランキング（ver.飲食店）」を記録保存できるアプリ
## コンセプト
このアプリは、自分のお気に入りの飲食店をランキング形式で記録しておくことができるオリジナルランキングアプリです。また、その個人の独断のランキングを集計して、それをまたランキングにした総合ランキングも見ることができます。

このアプリを開発した経緯は、作者自身がこれまで行ったことのない飲食店を新規開拓するときに参考になるアプリが欲しいと思っていたことと、プログラミングスクールの休憩中に他の生徒が「お菓子の中で何が一番好きですか？」という話題で盛り上がっていた光景を目にしたことがアイデアの素となっています。  

既存のランキングとは無縁の個人の好みが集まるアプリを作れば、プログラミングスクールで目にした好きなことの話で盛り上がれる場所が提供でき、作者のような既存の「幅広いユーザーに支持されている」ランキングではなかなか出会えないような、ローカルな飲食店を発掘できるのではないかと考えました。それがこのアプリケーション「docking」になります。
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
- [ ] フォロー機能
- [ ] メール通知機能
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
## 使用予定Gem
- jquery-rails
- jquery-ui-rails
- rails-jquery-autocomplete
- counter_culture
- carrierwave
- mini_magick
