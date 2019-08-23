class User < ApplicationRecord
  # validates
  validates :name, presence: true, length: { in: 1..500 }
  validates :email,
            presence: true,
            length: { in: 1..500 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: true
  validates :password, presence: true, length: { in: 6..100 }, allow_nil: true
  validates :admin, inclusion: { in: [true, false] }

  has_secure_password
  # セキュアにハッシュ化したパスワードを、データベース内のpassword_digestというカラムに保存する
  # 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。また、存在性と値が一致するかどうかのバリデーションも追加される
  # authenticateメソッドが使えるようになる (引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド)

  # association
  # TODO: foreign_key: { on_delete: :cascade }
  has_one :picture, as: :imageable, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :iine_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy

  # method
  def add_errors
    errors.add(:password, 'を入力してください')
  end

  # callback
  before_validation { email.downcase! }
  before_update :last_admin_user_update?
  before_destroy :last_admin_user_destroy?

  private

  def last_admin_user_update?
    admin_users = User.where(admin: true)
    if admin_users.count == 1 && admin_users.first == self && !admin
      errors.add(:admin, 'は、最低一名必要です。')
      throw :abort
    else
      true
    end
  end

  def last_admin_user_destroy?
    throw :abort if User.where(admin: true).count == 1 && admin
  end
end
