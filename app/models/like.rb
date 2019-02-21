class Like < ApplicationRecord
  # バリデーション
  validates :post_id, uniqueness: { scope: :user_id }
  validates :post_id, :user_id, presence: true
  # アソシエーション
  belongs_to :post
  belongs_to :user
  counter_culture :post
end
