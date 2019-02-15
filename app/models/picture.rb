class Picture < ApplicationRecord
  #imageカラムに、ImageUploaderを紐付け
  mount_uploader :image, ImageUploader
  # バリデーション
  validates :image, :imageable_type, :imageable_id, presence: true
  # アソシエーション
  belongs_to :imageable, polymorphic: true
end
