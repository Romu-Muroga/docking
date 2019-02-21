class Post < ApplicationRecord
  # バリデーション
  validates :ranking_point, presence: true
  validates :eatery_name, presence: true, length: { in: 1..200 }
  validates :eatery_food, presence: true, length: { in: 1..200 }
  validates :eatery_address, length: { maximum: 500 }
  validates :category_id, uniqueness: { scope: [:ranking_point, :user_id] }
  # validates: latitude# TODO: 要確認
  # validates: longitude# TODO: 要確認
  validates :eatery_website, length: { maximum: 500 }
  validates :remarks, presence: true
  # validates :image, presence: true# TODO: 要確認

  # enumを使えば、数字を意味のある文字として扱える。DBには割り当てられた整数が保存される。
  enum ranking_point: { １位: 3, ２位: 2, ３位: 1 }#ランキングポイント

  # アソシエーション
  belongs_to :user
  belongs_to :category
  has_one :picture, as: :imageable, dependent: :destroy#TODO: foreign_key: { on_delete: :cascade }

  # attr_accessor :image # for caching images table value

  # defo. [id, content].map { column: self.attr_accessor: column }
  # has_many(arg1, [...arg2])をすると
  # attr_accessor: arg1 # as
  # arg1を読んだときのメソッド(ex. before_get_arg1)ができる
  # def before_get_arg1
  #   @post = self # == Post.find(:id)
  #   @arg1 = Arg1.where(id: self.id)
  #   return @arg1
  # end
end
