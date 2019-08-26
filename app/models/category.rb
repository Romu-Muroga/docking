class Category < ApplicationRecord
  # validates
  validates :name, presence: true, length: { maximum: 500 }
  # association
  has_many :posts, dependent: :destroy
end
