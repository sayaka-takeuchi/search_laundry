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
User.create(id: 1, nickname: 'admin', email: 'test@com', password: 'aaaa1111', admin: true)
User.create(id: 2, nickname: 'user', email: 'sample@com', password: 'bbbb2222', admin: false)
User.create(id: 3, nickname: '佐藤', email: 'satou@com', password: 'cccc3333', admin: false)
User.create(id: 4, nickname: '太郎', email: 'tarou@com', password: 'dddd4444', admin: false)
User.create(id: 5, nickname: 'アイス', email: 'aisu@com', password: 'eeee5555', admin: false)

Comment.create(text:'いいと思います！', user_id:1, laundry_id: 1, gender: 1, age_id:3, rate_id: 4)
Comment.create(text:'とても雰囲気がよかったです！リピートします！', user_id:1, laundry_id: 3, gender: 1, age_id:3, rate_id: 4)
Comment.create(text:'店が汚い。もういかない', user_id:2, laundry_id: 3, gender: 2, age_id:5, rate_id: 1)
Comment.create(text:'まぁまぁ。', user_id:2, laundry_id: 5, gender: 3, age_id:2, rate_id: 3)
Comment.create(text:'いいと思います！', user_id:2, laundry_id: 4, gender: 3, age_id:2, rate_id: 4)
Comment.create(text:'可もなく不可もなく', user_id:3, laundry_id: 1, gender: 1, age_id:4, rate_id: 3)
Comment.create(text:'いいと思います！', user_id:3, laundry_id: 2, gender: 1, age_id:4, rate_id: 4)
Comment.create(text:'雨の日は混んでていつもいっぱい', user_id:3, laundry_id: 3, gender: 1, age_id:4, rate_id: 2)
Comment.create(text:'可もなく不可もなく', user_id:3, laundry_id: 4, gender: 1, age_id:4, rate_id: 3)
Comment.create(text:'いいと思います！', user_id:3, laundry_id: 5, gender: 1, age_id:4, rate_id: 4)
Comment.create(text:'Wi-fiがあっていい！', user_id:1, laundry_id: 1, gender: 1, age_id:4, rate_id: 3)
Comment.create(text:'いいと思います！', user_id:4, laundry_id: 7, gender: 3, age_id:8, rate_id: 4)
Comment.create(text:'雨の日はすごく混んでいる', user_id:4, laundry_id: 9, gender: 3, age_id:8, rate_id: 2)
Comment.create(text:'両替機が欲しい', user_id:4, laundry_id: 10, gender: 3, age_id:8, rate_id: 1)
Comment.create(text:'雑誌を置いて欲しい', user_id:4, laundry_id: 20, gender: 3, age_id:8, rate_id: 5)
Comment.create(text:'いいと思います！', user_id:4, laundry_id: 11, gender: 3, age_id:8, rate_id: 4)
Comment.create(text:'いいと思います！', user_id:4, laundry_id: 11, gender: 3, age_id:8, rate_id: 5)
Comment.create(text:'wifiがあるからいい', user_id:4, laundry_id: 13, gender: 3, age_id:8, rate_id: 4)
Comment.create(text:'いいと思います！', user_id:5, laundry_id: 14, gender: 1, age_id:8, rate_id: 4)
Comment.create(text:'いいと思います！', user_id:5, laundry_id: 18, gender: 1, age_id:8, rate_id: 3)
Comment.create(text:'花粉症の時期によく使います！', user_id:5, laundry_id: 10, gender: 1, age_id:8, rate_id: 4)
Comment.create(text:'いいと思います！', user_id:5, laundry_id: 20, gender: 1, age_id:3, rate_id: 1)
Comment.create(text:'家から近い！', user_id:5, laundry_id: 11, gender: 1, age_id:3, rate_id: 4)
Comment.create(text:'いいと思います！', user_id:5, laundry_id: 11, gender: 1, age_id:3, rate_id: 4)
Comment.create(text:'いいと思います！', user_id:5, laundry_id: 13, gender: 1, age_id:3, rate_id: 3)
Comment.create(text:'家から近くて便利です！', user_id:5, laundry_id: 14, gender: 1, age_id:3, rate_id: 5)
Comment.create(text:'多分もう使わない', user_id:5, laundry_id: 18, gender: 1, age_id:3, rate_id: 2)