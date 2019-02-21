class Category < ApplicationRecord
  # バリデーション
  validates :name, presence: true, length: { in: 1..500 }
  # アソシエーション
  has_many :posts
end
