FactoryBot.define do

  factory :post_like do
    post { nil }
    user { nil }
  end

  factory :second_post_like, class: Like do
    post { nil }
    user { nil }
  end
end
