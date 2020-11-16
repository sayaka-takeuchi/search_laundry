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
  laundry.image.attach(io: File.open("app/assets/images/image/image#{row['id']}.jpg"), filename: 'image.jpg')
  laundry.save
end
User.create(
  nickname: 'admin',  
  email: 'test@com',
  password: 'aaaa1111',
  admin: true
)
User.create(
  nickname: 'user', 
  email: 'sample@com',
  password: 'bbbb2222',
  admin: false
)
