FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'aaaa1111' }
    password_confirmation { 'aaaa1111' }
    admin { false }
  end
end
