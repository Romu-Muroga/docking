class Comment < ApplicationRecord
  # validation
  validates :content, presence: true
  # association
  belongs_to :user
  belongs_to :post
end
