class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, inverse_of: :imageable
end
