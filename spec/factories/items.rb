FactoryBot.define do
  factory :item do
    item_name             { '商品名' }
    detail                { '商品の説明' }
    category_id           { 2 }
    quality_id            { 2 }
    postage_id            { 2 }
    prefecture_id         { 2 }
    term_id               { 2 }
    price                 { 500 }

    association :user 

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/a.png'), filename: 'a.png')
    end
  end
end
