FactoryBot.define do

  factory :like do
    post {}
    user {}
  end

  factory :second_like, class: Like do
    post {}
    user {}
  end
end
