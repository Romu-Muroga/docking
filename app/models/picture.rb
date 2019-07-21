class Picture < ApplicationRecord
  #imageカラムに、ImageUploaderを紐付け
  mount_uploader :image, ImageUploader
  # validates
  validates :image, :imageable_type, :imageable_id, presence: true
  # association
  belongs_to :imageable, polymorphic: true
end
