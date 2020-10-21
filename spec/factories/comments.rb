FactoryBot.define do
  factory :comment do
    text { Faker::Lorem.sentence }
    gender { 1 }
    age_id { 1 }
    rate_id { 1 } 
    association :user
    association :laundry
  end
end
