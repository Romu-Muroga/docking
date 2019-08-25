class Post < ApplicationRecord
  # validation
  validates :category_id,
            presence: true,
            numericality: true,
            inclusion: { in: Category.pluck(:id) }
  validates :ranking_point,
            uniqueness: { scope: %i[category_id user_id] }
  validates :eatery_name, presence: true, length: { in: 1..200 }
  validates :eatery_food, presence: true, length: { in: 1..200 }
  validates :eatery_address, presence: true, length: { maximum: 500 }
  # validates: latitude
  # validates: longitude
  validates :eatery_website,
            presence: true,
            length: { maximum: 500 },
            format: { with: /\A#{URI.regexp(%w[http https])}\z/ },
            unless: :eatery_website?
  validates :remarks, length: { maximum: 2000 }

  # enum
  enum ranking_point: { first_place: 3, second_place: 2, third_place: 1 }

  # association
  has_and_belongs_to_many :hashtags, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  # TODO: foreign_key: { on_delete: :cascade }
  has_one :picture, as: :imageable, dependent: :destroy
  belongs_to :user
  belongs_to :category

  # scope
  scope :category_sort, ->(category_id) { where(category_id: category_id).latest }
  scope :user_category_sort, ->(user, category) { where(user_id: user).where(category_id: category).order(ranking_point: :desc) }
  scope :default_sort, -> { where(category_id: Category.first.id).order(ranking_point: :desc) }
  scope :iine_ranking, -> { order(likes_count: :desc).limit(10).includes(:user) }
  scope :latest, -> { order(updated_at: :desc).includes(:user) }
  # scope for autocomplete
  scope :uniq_eatery_name, -> { select('MIN(id) as id, eatery_name').group(:eatery_name) }
  scope :uniq_eatery_food, -> { select('MIN(id) as id, eatery_food').group(:eatery_food) }
  scope :uniq_eatery_address, -> { select('MIN(id) as id, eatery_address').group(:eatery_address) }

  # Iine to post.
  def iine(user)
    likes.create(user_id: user.id)
  end

  # Remove post iine.
  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  # Returns true if the current user iine
  def iine?(user)
    iine_users.include?(user)
  end

  # Overall ranking
  def self.overall_ranking
    # (self.)outputs_duplicate_shop_name_and_category
    eatery_points, dup_posts = outputs_duplicate_shop_name_and_category
    eatery_points.each do |k, v|
      dup_posts.each do |post|
        likes_and_ranking_points = post.ranking_point_before_type_cast + post.likes_count
        v[:point] += likes_and_ranking_points if post.eatery_name == k[0]
      end
    end
    Hash[eatery_points.sort_by { |_, v| -v[:point] }]
  end

  # selfが必要
  def self.outputs_duplicate_shop_name_and_category
    eatery_points = {}
    posts = Post.group(:eatery_name, :category_id)
                .having('count(*) >= 2')
                .pluck(:eatery_name, :category_id)
    posts = posts.each { |post| eatery_points[post] = { point: 0 } }.flatten
    dup_posts = Post.where(eatery_name: posts)
                    .or(Post.where(category_id: posts))
    return eatery_points, dup_posts
  end

  # callback
  before_validation :set_default
  # DBへのコミット直前に実施する
  after_create :create_hashtag
  before_update :update_hashtag

  private

  def set_default
    self.eatery_address = '未登録' if eatery_address.blank?
    self.eatery_website = '未登録' if eatery_website.blank?
  end

  def eatery_website?
    eatery_website == '' || eatery_website == '未登録'
  end

  def create_hashtag
    post = Post.find_by(id: self.id)
    # scan:引数に指定した文字列と一致する文字列を、全て配列にして取得する
    hashtags = remarks.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.tr('＃', '#').delete('#'))
      # postに付与されているhashtagの配列にtagを追加
      post.hashtags << tag
    end
  end

  def update_hashtag
    post = Post.find_by(id: self.id)
    # clear:要素をすべて削除し、配列を空にする
    post.hashtags.clear
    hashtags = remarks.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.tr('＃', '#').delete('#'))
      post.hashtags << tag
    end
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
