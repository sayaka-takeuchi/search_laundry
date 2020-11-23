FactoryBot.define do
  factory :laundry do
    name { 'コインランドリー豊橋店' }
    address { '愛知県名古屋市1-1' }
    opening_date { '2012-01-13' }
    open_time { '7:00' }
    close_time { '23:00' }
    shoe_washing { true }
    futon_washing { true }
    dryer { true }
    washing_machine { true }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end

    trait :invalid do
      name { nil }
    end
  end
end
