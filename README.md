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
![サンプル画像](demo1.jpg)
![トップページ mov](https://user-images.githubusercontent.com/78133210/113227590-01707e80-92ce-11eb-8b86-869c55c23db5.gif)
- トップページにログイン画面をつけたこと
- ユーザーが使ってみたいと思うようなデザイン作り

## ユーザーログイン機能
![ユーザーログイン mov](https://user-images.githubusercontent.com/78133210/113227518-d1c17680-92cd-11eb-9c76-41418646e6ef.gif)

## ユーザー一覧表示
![画面収録 1 mov](https://user-images.githubusercontent.com/78133210/113226062-28c54c80-92ca-11eb-8722-0b11b1e4022b.gif)
- サイトに登録してあるユーザーの一覧が表示される

## ユーザー検索機能
![国名検索 mov](https://user-images.githubusercontent.com/78133210/113226410-126bc080-92cb-11eb-9c89-9ba63b03d0ca.gif)
- 国名選択にはActiveHashの技術を用いて実装
- 国名を選択して検索をかけると該当する国名のユーザーが検索結果として表示される

## トーク作成機能
![トーク作成機能 mov](https://user-images.githubusercontent.com/78133210/113227127-d3d70580-92cc-11eb-8706-00fc1e6edd15.gif)
- トークをしたいユーザーを選び、詳細ページからトークするボタンを押下
- トーク作成ルームに移りトーク名を作成
- ページ遷移した後、右上欄からトークルームに遷移し、トークが開始される

## メッセージ投稿機能
![メッセージ投稿機能 mov](https://user-images.githubusercontent.com/78133210/113227321-624b8700-92cd-11eb-9a43-c3efdd55d686.gif)
- 右下のメッセージ欄からメッセージを投稿できる
- 画像の投稿も可能

## その他
- ユーザー編集機能
- トーク削除機能
- いいね機能
- フォロー機能

# 工夫したポイント
- 使い勝手の良さ
- 一度交流した人と以降も親交を深めるため、検索精度とマッチング率を上げるための工夫

# 使用技術
## バックエンド
Ruby, Ruby on Rails
## フロントエンド
HTML, CSS, JavaScript(jQuery)
## データベース
MySQL, SequelPro
## インフラ
AWS
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