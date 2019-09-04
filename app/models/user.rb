class User < ApplicationRecord
  # validation
  validates :name, presence: true, length: { maximum: 500 }
  validates :email,
            presence: true,
            length: { maximum: 500 },
            uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, allow_blank: true
  validates :password, presence: true, length: { in: 6..100 }, allow_nil: true
  validates :admin, inclusion: { in: [true, false] }
  has_secure_password

  # association
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
