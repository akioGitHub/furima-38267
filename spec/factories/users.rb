FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {'a000000'}
    password_confirmation {password}
    last_name             {person.last.kanji}
    first_name            {person.first.kanji}
    last_kana_name        {person.last.katakana}
    first_kana_name       {person.first.katakana}
    birthday              {Faker::Date.birthday(min_age: 18, max_age: 65)}
  end
end