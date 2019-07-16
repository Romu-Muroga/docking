class PostHashtag < ApplicationRecord
  # validates
  validates :post_id, presence: true
  validates :hashtag_id, presence: true
  # association
  belongs_to :post
  belongs_to :hashtag
end
