class PayForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :token

  with_options presence: true do
    validates :token
    validates :user_id, :item_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :city, :house_number
    validates :phone_number, numericality: { only_integer: true, message: 'is invalid. Input only number' }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  validates :phone_number, length: { minimum: 10, message: 'is too short' }
  validates :phone_number, length: { maximum: 11, message: 'is invalid' }

  def save
    user_item = UserItem.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(post_code: post_code, prefecture_id: prefecture_id, city: city, house_number: house_number,building_name: building_name, phone_number: phone_number, user_item_id: user_item.id)
  end
end
