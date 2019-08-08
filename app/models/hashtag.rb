class Hashtag < ApplicationRecord
  # validates
  validates :hashname, presence: true, length: { in: 1..99 }
  # association
  has_and_belongs_to_many :posts, dependent: :destroy
end
