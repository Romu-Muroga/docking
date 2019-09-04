FactoryBot.define do
  factory :post do
    ranking_point { 'first_place' }
    eatery_name { 'テストレストラン' }
    eatery_food { 'テストフード' }
    eatery_address {}
    eatery_website {}
    remarks { '' }
    category
    user
  end
end
