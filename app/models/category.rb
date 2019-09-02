class Category < ApplicationRecord
  # validation
  validates :name, presence: true, length: { maximum: 500 }
  # association
  has_many :posts, dependent: :destroy
end
