class Post < ApplicationRecord
  # バリデーション
  validates :ranking_point, presence: true
  validates :eatery_name, presence: true, length: { in: 1..200 }
  validates :eatery_food, presence: true, length: { in: 1..200 }
  validates: :eatery_address, length: { maximum: 500 }
  # validates: latitude
  # validates: longitude
  validates: :eatery_website, length: { maximum: 500 }
  validates: :remarks, presence: true

end
