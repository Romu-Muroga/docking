class Post < ApplicationRecord
  # バリデーション
  validates :ranking_point, presence: true
  validates :eatery_name, presence: true, length: { in: 1..200 }
  validates :eatery_food, presence: true, length: { in: 1..200 }
  validates :eatery_address, length: { maximum: 500 }
  validates :ranking_point, uniqueness: { scope: %i[category_id user_id] }
  # validates: latitude# TODO: 要確認
  # validates: longitude# TODO: 要確認
  validates :eatery_website, length: { maximum: 500 }#, format: { with: /\A#{URI::regexp(%w(http https))}\z/ }
  validates :remarks, presence: true

  # enumを使えば、数字を意味のある文字として扱える。DBには割り当てられた整数が保存される。
  enum ranking_point: { １位: 3, ２位: 2, ３位: 1 }# ランキングポイント

  # アソシエーション
  belongs_to :user
  belongs_to :category
  has_one :picture, as: :imageable, dependent: :destroy# TODO: foreign_key: { on_delete: :cascade }
  has_many :likes
  has_many :iine_users, through: :likes, source: :user#「ポストにいいねをしたユーザーの一覧」という関連
  has_many :comments

  # scope
  scope :latest, -> { order(updated_at: :desc).includes(:user) }# 更新順に並び替えかつN+1問題対策
  scope :category_sort, ->(category_id) { where(category_id: category_id).latest }
  scope :iine_ranking, -> { order(likes_count: :desc).limit(10).includes(:user) }# １０位までかつN+1問題対策
  scope :all_search, ->(address, category, rank, name) {
    where('eatery_address LIKE ?', "%#{address}%")
    .where(category_id: category)
    .where(ranking_point: rank)
    .where('eatery_name LIKE ?', "%#{name}%")
    .latest
  }
  scope :address_search, ->(address) { where('eatery_address LIKE ?', "%#{address}%").latest }
  scope :category_search, ->(category) { where(category_id: category).latest }
  scope :rank_search, ->(rank) { where(ranking_point: rank).latest }
  scope :name_search, ->(name) { where('eatery_name LIKE ?', "%#{name}%").latest }
  scope :user_category_sort, ->(user, category) { where(user_id: user).where(category_id: category).order(ranking_point: :desc) }
  scope :default_sort, -> { where(category_id: Category.first.id).order(ranking_point: :desc) }

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
  # def self.overall_ranking
  #   posts = Post.group(:eatery_name, :category_id).having('count(*) >= 2').pluck(:eatery_name, :category_id)
  #   # => [["aaa", 3], ["天狗", 1]]
  #   eatery_points = {}
  #   posts.each { |post| eatery_points[post] = {point: 0} }
  #   # => {["aaa", 3]=>{:point=>0}, ["天狗", 1]=>{:point=>0}}
  #   posts = posts.flatten
  #   # => ["aaa", 3, "天狗", 1]
  #   dup_records = Post.where(eatery_name: posts).where(category_id: posts)
  #   # => ["aaa", 3, "天狗", 1]と一致したレコードが全て取得できる
  #   eatery_points.each do |key, value|
  #     dup_records.each do |one|
  #       value[:point] = value[:point] + one.ranking_point_before_type_cast + one.likes_count if one.eatery_name == key[0]
  #     end
  #   end
  #   # => {["aaa", 3]=>{:point=>6}, ["天狗", 1]=>{:point=>10}}
  #   # ポイントが加算されていくはずが...console上だと
  #   # one.ranking_point => "１位" or "２位" or "３位"
  #   # になってしまいIntegerにStringは + できませんと怒られる...
  #   Hash[ eatery_points.sort_by{ |k, v| -v[:point] } ]
  #   # => {["aaa", 3]=>{:point=>10}, ["天狗", 1]=>{:point=>6}}
  # end

  # 総合ランキング（リファクタリング後）
  def self.overall_ranking
    eatery_points, dup_posts = outputs_duplicate_shop_name_and_category# selfが省略されている
    eatery_points.each do |k, v|
      dup_posts.each do |post|
        likes_and_ranking_points = post.ranking_point_before_type_cast + post.likes_count
        v[:point] += likes_and_ranking_points if post.eatery_name == k[0]
      end
    end
    Hash[eatery_points.sort_by { |_, v| -v[:point] }]
  end

  def self.outputs_duplicate_shop_name_and_category# selfが必要
    eatery_points = {}
    posts = Post.group(:eatery_name, :category_id).having('count(*) >= 2').pluck(:eatery_name, :category_id)
    posts = posts.each { |post| eatery_points[post] = { point: 0 } }.flatten
    dup_posts = Post.where(eatery_name: posts).or(Post.where(category_id: posts))
    return eatery_points, dup_posts
  end

  # コールバック
  before_save :set_default
  before_update :set_default

  private

  def set_default# TODO: DBのdefault値の役割は？
    # eatery_addressとeatery_website値に未登録をセット
    self.eatery_address = '未登録' if eatery_address.blank?
    self.eatery_website = '未登録' if eatery_website.blank?
  end

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
