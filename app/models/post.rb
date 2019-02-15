class Post < ApplicationRecord
  # バリデーション
  validates :ranking_point, presence: true
  validates :eatery_name, presence: true, length: { in: 1..200 }
  validates :eatery_food, presence: true, length: { in: 1..200 }
  validates :eatery_address, length: { maximum: 500 }
  validates :category_id, uniqueness: { scope: [:ranking_point, :user_id] }
  # validates: latitude
  # validates: longitude
  validates :eatery_website, length: { maximum: 500 }
  validates :remarks, presence: true

  # enumを使えば、数字を意味のある文字として扱える。DBには割り当てられた整数が保存される。
  enum ranking_point: { １位: 3, ２位: 2, ３位: 1 }#ランキングポイント

  # アソシエーション
  belongs_to :user
  belongs_to :category
  has_many :images, as: :imageable, inverse_of: :imageable, dependent: :destroy#TODO: foreign_key: { on_delete: :cascade }
  accepts_nested_attributes_for :images

end
