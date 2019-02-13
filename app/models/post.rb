class Post < ApplicationRecord
  # バリデーション
  validates :ranking_point, presence: true
  validates :eatery_name, presence: true, length: { in: 1..200 }
  validates :eatery_food, presence: true, length: { in: 1..200 }
  validates :eatery_address, length: { maximum: 500 }
  # validates: latitude
  # validates: longitude
  validates :eatery_website, length: { maximum: 500 }
  validates :remarks, presence: true

  # enumを使えば、数字を意味のある文字として扱える。DBには割り当てられた整数が保存される。
  enum ranking_point: { １位: 3, ２位: 2, ３位: 1 }#ランキングポイント

end
