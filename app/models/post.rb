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
  # validates :image, presence: true# TODO: 写真が選択されていなかったときのバリデーションは？

  # enumを使えば、数字を意味のある文字として扱える。DBには割り当てられた整数が保存される。
  enum ranking_point: { １位: 3, ２位: 2, ３位: 1 }#ランキングポイント

  # アソシエーション
  belongs_to :user
  belongs_to :category
  has_one :picture, as: :imageable, dependent: :destroy# TODO: foreign_key: { on_delete: :cascade }
  has_many :likes
  has_many :iine_users, through: :likes, source: :user#「ポストにいいねをしたユーザーの一覧」という関連

  # いいね機能
  # Postをいいねする
  def iine(user)
    likes.create(user_id: user.id)
  end
  # Postのいいねを解除する
  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end
  # 現在のユーザーがいいねしてたらtrueを返す
  def iine?(user)
    iine_users.include?(user)
  end

  # 総合ランキング
  def self.overall_ranking
    posts = Post.group(:eatery_name).having('count(*) >= 2').pluck(:eatery_name)
    # => ["はまぐりラーメン", "ラーメン次郎"]
    eatery_points = {}
    posts.each { |post| eatery_points[post] = {point: 0} }
    # => {"はまぐりラーメン"=>{:point=>0}, "ラーメン次郎"=>{:point=>0}}
    dup_records = Post.where(eatery_name: posts)
    # => ["はまぐりラーメン", "ラーメン次郎"]と一致したレコードが全て取得できる
    eatery_points.each do |key, value|
      dup_records.each do |one|
        value[:point] = value[:point] + one.ranking_point_before_type_cast if one.eatery_name == key
      end
    end
    # => {"はまぐりラーメン"=>{:point=>0}, "ラーメン次郎"=>{:point=>0}}
    # ポイントが加算されていくはずが...console上だと
    # one.ranking_point => "１位" or "２位" or "３位"
    # になってしまいIntegerにStringは + できませんと怒られる...
    Hash[ eatery_points.sort_by{ |k, v| -v[:point] } ]
    # => {"ラーメン次郎"=>{:num=>9}, "はまぐりラーメン"=>{:num=>6}}
  end

  # コールバック
  before_save :set_default
  before_update :set_default

  private
  def set_default# TODO: DBのdefault値の役割は？
    # eatery_addressとeatery_website値に未登録をセット
    self.eatery_address = "未登録" if eatery_address.blank?
    self.eatery_website = "未登録" if eatery_website.blank?
  end

  # attr_accessor :image # for caching images table value
  # attr_reader :image

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
