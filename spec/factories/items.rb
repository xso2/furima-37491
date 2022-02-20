FactoryBot.define do
  factory :item do
    name          {"名前"}
    introduction    {"説明説明説明"}
    price           {2000}
    item_condition_id  {2}
    postage_payer_id   {2}
    prefecture_id      {2}
    preparation_day_id {2}
    category_id        {2}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end