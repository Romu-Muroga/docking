FactoryBot.define do
  # factory :post_picture, class: Picture do
  #   association :imageable, factory: :post
  # end
  #
  # factory :user_picture, class: Picture do
  #   association :imageable, factory: :user
  # end
  #
  # factory :post do
  #   ranking_point { 3 }
  #   eatery_name { "和食レストラン" }
  #   eatery_food { "サバの味噌煮定食" }
  #   eatery_address { "未登録" }
  #   eatery_website { "未登録" }
  #   remarks { "美味しかった！" }
  #   likes_count { 0 }
  #   category { 1 }
  #   user { 1 }
  # end
  #
  # factory :user do
  #   name { "test_user_01" }
  #   email { "test_user_01@dic.com" }
  #   password { "password" }
  # end

  factory :picture do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/default.png')) }
    imageable_id {}
    imageable_type {}
  end
end
