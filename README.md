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
- has_many :purchase_records



## items テーブル

| Column          | Type       | Options                        |
| -------         | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| introduction    | text       | null: false                    |
| price           | integer    | null: false                    |
| item_condition  | integer    | null: false                    |
| category        | integer    | null: false                    |
| postage_payer   | integer    | null: false                    |
| preparation_day | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |


### Association
- belongs_to :users
- has_one :sending_destinations



## shipping_address テーブル

| Column        | Type       | Options                        |
| -------       | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| city          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |


### Association
- has_one :user
- has_one :purchase_records



## user_item テーブル

| Column        | Type       | Options                        |
| -------       | ---------- | ------------------------------ |
| user          | string     | null: false  foreign_key: true |
| item          | string     | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item