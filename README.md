# 要件定義
## 概要
「自分だけのこだわりのランキング（ver.飲食店）」を記録保存できるアプリ
## コンセプト
このアプリは、世間の流行とは無縁の自分だけが気に入っている飲食店を、ランキング形式で記録しておくことができるアプリです。  
対象とするユーザーは、インターネットで「東京　おすすめ　レストラン」と検索して表示される、おすすめ情報では満足できない、そんなこだわりを持つユーザーを対象としています。おすすめランキングというものは「幅広いユーザーに支持されている」ランキングのため８０点を引く確率は高いのですが、大当たりにはなかなか出会えない。大当たりの店はランキングとは無縁の個人の好み中にあるからです。

そんな個人の好みが集まる場所がもしあれば、そこで集計されたランキングは個人個人で勝手に決めたランキングの集計のため、既存のランキングサイトでは出会うことがない、一風変わったランキングを見ることができるのではないかと考えました。それがこのアプリケーション「docking」になります。
## バージョン
RUby 2.5.3  
Rails 5.2.2
## 機能一覧
- [ ] ログイン機能  
- [ ] アカウント登録機能（名前, Email, パスワードは必須）  
- [ ] マイページ機能（カテゴリー毎に３位までのランキングを登録できる）  
- [ ] ランキング一覧機能（各カテゴリー毎に１位一覧、２位一覧、３位一覧、総合ランキング、いいねランキング）   
- [ ] いいね機能  
- [ ] フォロー機能  
- [ ] メール通知機能  
- [ ] コメント機能
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
- rails4-autocomplete  
- counter_culture
- carrierwave  
- mini_magick  
- dotenv-rails  
- faker  
- letter_opener_web
