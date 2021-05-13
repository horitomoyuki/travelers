# アプリケーション名
Travelers

# 概要
同じ国に旅する人同士で交流し合うオンライン掲示板サービス

# 本番環境
## URL
http://18.178.165.200/

ログイン情報（テスト用）
- Eメール：test@test.com
- パスワード：abc123
またはゲストログインにより、ログイン可能

# 制作背景
- 制作意図
初めての海外旅行で同じ日本人と出会い、人見知りな自分でもその人と仲良く慣れたという経験から、海外で同じ国籍の人と交流したいというニーズがあると考えて作成
- ペルソナ
老若男女問わず海外旅行と人と交流するのが好きな人
- ユースケース
初めての海外旅行で知らない土地に不安を覚えている人が、同じく初めての海外旅行を経験している人と行動を共にしたい
バックパッカーとして世界一周旅行している人が現地の同じ国籍の人たちと旅をしながら交流を深めていくために利用する
- 課題解決
海外旅行する上での不安感を取り除く
海外で同じ国籍の人と交流を深めたい

# DEMO
## トップページ
[![Image from Gyazo](https://i.gyazo.com/b07fbb1aa5e1b2ad50c97f1d501cd109.gif)](https://gyazo.com/b07fbb1aa5e1b2ad50c97f1d501cd109)
- トップページにログイン画面をつけたこと
- ユーザーが使ってみたいと思うようなデザイン作り

## ログイン機能(device)
[![Image from Gyazo](https://i.gyazo.com/af7cf6a8427e1e120d658a6abe677d79.gif)](https://gyazo.com/af7cf6a8427e1e120d658a6abe677d79)
- ユーザーログインと新規登録機能を実装
## ゲストログイン機能
[![Image from Gyazo](https://i.gyazo.com/c89edba0dfaa4eb683ea8a102d47b499.gif)](https://gyazo.com/c89edba0dfaa4eb683ea8a102d47b499)
- 新規登録せずにログイン可能

## 検索機能(ransack)
[![Image from Gyazo](https://i.gyazo.com/fcabbdc97f902f1ddef0242b9a56406e.gif)](https://gyazo.com/fcabbdc97f902f1ddef0242b9a56406e)
- 国名選択にはActiveHashの技術を用いて実装
- 国名を選択して検索をかけると該当する国名のユーザーが検索結果として表示される

## いいね機能(ajax)
[![Image from Gyazo](https://i.gyazo.com/53c17e06052554fd643cbc166b8b29ff.gif)](https://gyazo.com/53c17e06052554fd643cbc166b8b29ff)
非同期通信によりいいね機能を実装

## フォロー機能(ajax)
[![Image from Gyazo](https://i.gyazo.com/9c38385cc060ad65f8ad6ffbd89ce75a.gif)](https://gyazo.com/9c38385cc060ad65f8ad6ffbd89ce75a)
非同期通信によって自分のお気に入りのユーザーをフォローする

## トーク作成機能
[![Image from Gyazo](https://i.gyazo.com/46a2313d33f49c8d960b331f0e7642c8.gif)](https://gyazo.com/46a2313d33f49c8d960b331f0e7642c8)
- トークをしたいユーザーを選び、詳細ページからトークするボタンを押下
- トーク作成ルームに移りトーク名を作成

## メッセージ投稿機能
[![Image from Gyazo](https://i.gyazo.com/74bbadcc10d0ed37bf56287b71b2baeb.gif)](https://gyazo.com/74bbadcc10d0ed37bf56287b71b2baeb)
- 右下のメッセージ欄からメッセージを投稿できる
- 画像投稿機能(ActiveStorage)で画像投稿も可能

# 工夫したポイント
- 使い勝手の良さ
- 一度交流した人と以降も親交を深めるため、検索精度とマッチング率を上げるための工夫

# 使用技術
## バックエンド
Ruby:2.6.5, Ruby on Rails:6.0.0
## フロントエンド
HTML, CSS, JavaScript(jQuery),WebPacker
## データベース
MySQL, SequelPro
## インフラ
AWS(EC2), nginx, unicorn
## ソース管理
GitHub, GitHubDesktop
## テスト
RSpec
## エディタ
VSCode
# 課題・実装予定機能
- コメント返信機能

# テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| name               | string  | null: false |
| email              | string  | null: false |
| password           | string  | null: false |
| encrypted_password | string  | null: false |
| introduction       | text    |             |
| age                | integer |             |
| job_id             | integer |             |
| birthplace_id      | integer |             |
| residence_id       | integer |             |

### Association

- has_many :room_users
- has_many :rooms, through: room_users
- has_many :talks
- has_many :relationships, dependent: :destroy
- has_many :followings, through: :relationships, source: :follower
- has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
- has_many :followers, through: :passive_relationships, source: :user
- has_many :favorites, dependent: :destroy
- has_many :likings, through: :favorites, source: :like
- has_many :passive_favorites, class_name: 'Favorite', foreign_key: 'like_id', dependent: :destroy
- has_many :likes, through: :passive_favorites, source: :user

## rooms テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :room_users
- has_many :users, through: room_users
- has_many :talks

## room_users テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| room   | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

## talks テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| content | string     |                                |
| user    | references | null: false, foreign_key: true |
| room    | references | null: false, foreign_key: true |

### Association

- belongs_to :room
- belongs_to :user

## relationships テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true | 
| follower | references | null: false, foreign_key: true | 

### Association

- belongs_to :user
- belongs_to :follower, class_name: 'User'

## favorites テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true | 
| like    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :like, class_name: 'User'