class Category < ApplicationRecord
  # validation
  # TODO: name_en => presence: true
  validates :name_ja, presence: true, length: { maximum: 500 }
  validates :name_en, presence: true, length: { maximum: 500 }
  # association
  has_many :posts, dependent: :destroy
end
