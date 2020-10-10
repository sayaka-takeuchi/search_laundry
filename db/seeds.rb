20.times do |n|
  laundry = Laundry.new(
    name: "コインランドリー#{n + 1}号店",
    address: "愛知県名古屋市1-#{n + 1}",
    opening_date: Faker::Date.between(from: '2000-01-01', to: Date.today),
    open_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    close_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    shoe_washing: %w(true false).sample,
    futon_washing: %w(true false).sample,
    dryer: %w(true false).sample,
    washing_machine: %w(true false).sample,
    ) 
  laundry.image.attach(io: File.open('public/images/image.jpg'), filename: 'test_image.jpg')
  laundry.save
end
user = User.new(
  nickname: 'admin', 
  first_name: '鈴木', 
  last_name: '太郎', 
  first_name_kana: 'スズキ',
  last_name_kana: 'タロウ', 
  email: 'test@com',
  password: 'aaaa1111',
  admin: true
)
user.save!