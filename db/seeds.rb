require "csv"

CSV.foreach('db/store.csv', headers: true) do |row|
  laundry = Laundry.new(
    name: row['name'] ,
    address: row['address'],
    opening_date: row['opening_date'],
    open_time: row['open_time'],
    close_time: row['close_time'],
    shoe_washing: row['shoe_washing'],
    futon_washing: row['futon_washing'],
    dryer: row['dryer'],
    washing_machine: row['washing_machine']
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