# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

test_user_1 = User.create(nickname: "次郎", email: "jiro@taro", password: "1jirojiro", last_name: "山田", first_name: "次郎", last_kana_name: "ヤマダ", first_kana_name: "ジロウ", birthday: "2000-08-01")
test_user_2 = User.create(nickname: "花子", email: "hanako@hanako", password: "1hanakohanako", last_name: "田中", first_name: "花子", last_kana_name: "タナカ", first_kana_name: "ハナコ", birthday: "2000-09-01")

item_1 = Item.new(
 item_name: "スマートフォン",
 detail: "iphone11PRO",
 category_id: 7,
 quality_id: 3,
 postage_id: 3,
 prefecture_id: 3,
 term_id: 3,
 price: 50000,
 user_id: test_user_1.id
 )
item_1.images.attach(io: File.open(Rails.root.join("./app/assets/images/smartphone.png")), filename: 'smartphone.png')
item_1.save

item_2 = Item.new(
 item_name: "子供服",
 detail: "幼児用",
 category_id: 5,
 quality_id: 2,
 postage_id: 2,
 prefecture_id: 29,
 term_id: 2,
 price: 1000,
 user_id: test_user_2.id
 )
item_2.images.attach(io: File.open(Rails.root.join("./app/assets/images/clothes.png")), filename: 'clothes.png')
item_2.save

item_3 = Item.create(
 item_name: "ドライヤー",
 detail: "マイナスイオン機能付き",
 category_id: 4,
 quality_id: 2,
 postage_id: 3,
 prefecture_id: 18,
 term_id: 3,
 price: 3000,
 user_id: test_user_2.id
 )
item_3.images.attach(io: File.open(Rails.root.join("./app/assets/images/hairdryer.jpeg")), filename: 'hairdryer.jpeg')
item_3.save