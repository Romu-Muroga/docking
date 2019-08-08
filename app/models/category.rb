class Category < ApplicationRecord
  # validates
  validates :name, presence: true, length: { in: 1..500 }
  # association
  has_many :posts, dependent: :destroy
end
