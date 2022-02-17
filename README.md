# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false, unique: true|
| encrypted_password | string | null: false |
| nickname           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| birth_date         | date   | null: false |

### Association
- has_many :items
- has_many :user_items



## items テーブル

| Column              | Type       | Options                        |
| -------             | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| introduction        | text       | null: false                    |
| price               | integer    | null: false                    |
| item_condition_id   | integer    | null: false                    |
| category_id         | integer    | null: false                    |
| postage_payer_id    | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| preparation_day_id  | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_one :user_item



## shipping_addresses テーブル

| Column         | Type       | Options                        |
| -------        | ---------- | ------------------------------ |
| post_code      | string     | null: false                    |
| prefecture_id  | integer    | null: false                    |
| city           | string     | null: false                    |
| house_number   | string     | null: false                    |
| building_name  | string     |                                |
| phone_number   | string     | null: false                    |
| user_item      | references | null: false, foreign_key: true |


### Association
- belongs_to :user_item


## user_items テーブル

| Column           | Type       | Options                        |
| -------          | ---------- | ------------------------------ |
| user             | string     | null: false  foreign_key: true |
| item             | string     | null: false  foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address