＃テーブル設計

## users テーブル

| Column             | Type     | Options                   |
| ------------------ | -------- | ------------------------- |
| nickname           | string   | null: false               |
| email              | string   | null: false, unique: true |
| encrypted_password | string   | null: false               |
| last_name          | string   | null: false               |
| first_name         | string   | null: false               |
| last_kana-name     | string   | null: false               |
| first_kana-name    | string   | null: false               |
| birthday           | datetime | null: false               |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_name          | string     | null: false                    |
| detail             | text       | null: false                    |
| category_id        | integer    | null: false                    |
| quality_id         | integer    | null: false                    |
| postage_id         | integer    | null: false                    |
| prefectures_id     | integer    | null: false                    |
| term_id            | integer    | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order


## orders テーブル

| Column             | Type         | Options                              |
| ------------------ | ------------ | ------------------------------------ |
| item               | references   | null: false, foreign_key: true       |
| user               | references   | null: false, foreign_key: true       |


### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address


## shipping_addressテーブル

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| post_code          | string     | null: false                    |
| prefectures_id     | integer    | null: false                    |
| municipalities     | string     | null: false                    |
| house_number       | string     | null: false                    |
| building_name      | string     |                                |
| phon_number        | string     | null: false                    |
| order              | references | null: false, foreign_key: true |

### Association

- belongs_to :order




