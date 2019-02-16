class Like < ApplicationRecord
  # バリデーション
  validates :post_id, uniqueness: { scope: :user_id }
  # アソシエーション
  belongs_to :post
  belongs_to :user
end
