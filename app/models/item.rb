class Item < ApplicationRecord

  belongs_to :user
  #has_one :user_item

  has_one_attached :image

end
