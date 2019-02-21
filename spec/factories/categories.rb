FactoryBot.define do

  factory :category do
    name { "和食" }
  end

  factory :second_category, class: Category do
    name { "ラーメン・麺類" }
  end
end
