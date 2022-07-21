＃テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| password           | string | null: false               |
| last-name          | string | null: false               |
| first-name         | string | null: false               |
| last-kana-name     | string | null: false               |
| first-kana-name    | string | null: false               |
| year-of-birth      | string | null: false               |
| month-of-birth     | string | null: false               |
| day-of-birth       | string | null: false               |

### Association

- has_many :items
- has_many :comments
- has_many :order
- has_many :shipping-address


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| image              | text       | null: false                    |
| item-name          | string     | null: false                    |
| detail             | text       | null: false                    |
| category           | string     | null: false                    |
| quality            | string     | null: false                    |
| postage            | string     | null: false                    |
| place              | string     | null: false                    |
| term               | string     | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
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
| post-code          | integer    | null: false                    |
| prefectures        | string     | null: false                    |
| municipalities     | string     | null: false                    |
| house-number       | string     | null: false                    |
| building-name      | string     |                                |
| phon-number        | integer    | null: false                    |
| order              | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |
### Association

- belongs_to :order
- belongs_to :user


## comments テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| text               | text       | null: false                    |
| item               | references | null: false, foreign_key: true |
| user               | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- belongs_to :user


