FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    # first_name { '鈴木' }
    # last_name { '太郎' }
    # first_name_kana { 'スズキ' }
    # last_name_kana { 'タロウ' }
    email { Faker::Internet.email }
    password { 'aaaa1111' }
    password_confirmation { 'aaaa1111' }
    admin { false }
  end
end
