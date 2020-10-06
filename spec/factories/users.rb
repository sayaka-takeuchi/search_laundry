FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    first_name { '鈴木' }
    last_name { '太郎' }
    first_name_kana { 'スズキ' }
    last_name_kana { 'タロウ' }
    email { Faker::Internet.email }
    password = Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
    admin { 0 }
  end
end