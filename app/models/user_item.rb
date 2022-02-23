class UserItem < ApplicationRecord
  has_one :shippingAddress
  belongs_to :user
  belongs_to :item
end
