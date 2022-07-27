FactoryBot.define do
  factory :order_shipping_address do
    post_code             { '123-4567' }
    prefecture_id         { 2 }
    municipalitie         { '横浜市' }
    house_number          { '1-5' }
    building_name         { '青山ビル' }
    phone_number          { '09012345678' }

    association :user
  end
end
