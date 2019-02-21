# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Category.create!(name: "和食")
# Category.create!(name: "ラーメン・麺類")
# Category.create!(name: "丼もの・揚げ物")
# Category.create!(name: "お好み焼き・粉物")
# Category.create!(name: "郷土料理")
# Category.create!(name: "アジア・エスニック")
# Category.create!(name: "中華")
# Category.create!(name: "イタリアン")
# Category.create!(name: "フレンチ")
# Category.create!(name: "焼肉・ステーキ")
# Category.create!(name: "焼き鳥・串料理")
# Category.create!(name: "こだわりの肉料理")
# Category.create!(name: "鍋")
# Category.create!(name: "しゃぶしゃぶ・すき焼き")
# Category.create!(name: "その他")

Post.create!(ranking_point: 3,
             eatery_name: "魚べえ",
             eatery_food: "生しらす定食",
             eatery_address: "東京都渋谷区宇田川町28-6",
             eatery_website: "aaa@dic.com",
             remarks: "美味しかった！",
             category_id: 1,
             user_id: 1
            )
Post.create!(ranking_point: 2,
             eatery_name: "kitchen suzuki",
             eatery_food: "豚汁",
             eatery_address: "東京都渋谷区道玄坂2-25",
             eatery_website: "bbb@dic.com",
             remarks: "美味しかった！",
             category_id: 1,
             user_id: 1
            )
Post.create!(ranking_point: 1,
             eatery_name: "四季折々",
             eatery_food: "竹の子ご飯",
             eatery_address: "東京都渋谷区神宮前1-13-18",
             eatery_website: "ccc@dic.com",
             remarks: "美味しかった！",
             category_id: 1,
             user_id: 1
            )
Post.create!(ranking_point: 3,
             eatery_name: "杉田や",
             eatery_food: "チャーシュー麺",
             eatery_address: "東京都渋谷区宇田川町28-6",
             eatery_website: "aaa@dic.com",
             remarks: "美味しかった！",
             category_id: 2,
             user_id: 1
            )
Post.create!(ranking_point: 2,
             eatery_name: "ラーメン三郎",
             eatery_food: "大盛りラーメン",
             eatery_address: "東京都渋谷区道玄坂2-25",
             eatery_website: "bbb@dic.com",
             remarks: "美味しかった！",
             category_id: 2,
             user_id: 1
            )
Post.create!(ranking_point: 1,
             eatery_name: "中華一番",
             eatery_food: "あさりラーメン",
             eatery_address: "東京都渋谷区神宮前1-13-18",
             eatery_website: "ccc@dic.com",
             remarks: "美味しかった！",
             category_id: 2,
             user_id: 1
            )
