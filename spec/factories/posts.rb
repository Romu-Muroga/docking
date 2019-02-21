FactoryBot.define do
  # factory :post_picture, class: Picture do
  #   association :imageable, factory: :post
  # end
  #
  # factory :post_picture, class: Picture do
  #   association :imageable, factory: :second_post
  # end

  factory :post do
    ranking_point { 3 }
    eatery_name { "和食レストラン" }
    eatery_food { "サバの味噌煮定食" }
    eatery_address { "未登録" }
    eatery_website { "未登録" }
    remarks { "美味しかった！" }
    likes_count { 0 }
    category {}
    user {}
  end

  factory :second_post, class: Post do
    ranking_point { 3 }
    eatery_name { "ラーメン屋" }
    eatery_food { "チャーシュー麺" }
    eatery_address { "未登録" }
    eatery_website { "未登録" }
    remarks { "美味しかった！" }
    likes_count { 0 }
    category {}
    user {}
  end
end
