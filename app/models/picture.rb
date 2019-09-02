class Picture < ApplicationRecord
  #imageカラムに、ImageUploaderを紐付け
  mount_uploader :image, ImageUploader
  # validation
  validates :image, :imageable_type, :imageable_id, presence: true
  # association
  belongs_to :imageable, polymorphic: true
  # method
  def self.random_post_picture_id
    where(imageable_type: 'Post').pluck(:id).sample
  end
end
