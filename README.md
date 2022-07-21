＃テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last-name          | string | null: false               |
| first-name         | string | null: false               |
| last-kana-name     | string | null: false               |
| first-kana-name    | string | null: false               |
| datetime           | string | null: false               |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item-name          | string     | null: false                    |
| detail             | text       | null: false                    |
| category           | string     | null: false                    |
| quality            | string     | null: false                    |
| postage            | string     | null: false                    |
| prefectures        | string     | null: false                    |
| term               | string     | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order


## order テーブル

| Column             | Type         | Options                              |
| ------------------ | ------------ | ------------------------------------ |
| item               | references   | null: false, foreign_key: true       |
| user               | references   | null: false, foreign_key: true       |


### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping-address


## shipping-addressテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post-code          | string     | null: false                    |
| prefectures        | string     | null: false                    |
| municipalities     | string     | null: false                    |
| house-number       | string     | null: false                    |
| building-name      | string     |                                |
| phon-number        | string     | null: false                    |
| order              | references | null: false, foreign_key: true |

### Association

- belongs_to :order




