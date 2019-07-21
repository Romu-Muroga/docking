class Like < ApplicationRecord
  # validates
  validates :post_id, uniqueness: { scope: :user_id }
  validates :post_id, :user_id, presence: true
  # association
  belongs_to :post
  belongs_to :user
  counter_culture :post
end
