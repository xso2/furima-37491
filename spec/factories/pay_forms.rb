FactoryBot.define do
  factory :pay_form do
    post_code        { '123-4567' }
    prefecture_id    { Faker::Number.between(from: 2, to: 48) }
    city             { Faker::Address.city }
    address          { Faker::Address.street_address }
    building_name    { Faker::Address.building_number }
    phone_number     { Faker::Number.leading_zero_number(digits: 10) }
    token            { 'tok_abcdefghijk00000000000000000' }
  end
end
