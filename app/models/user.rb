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
  def password_insert_errors(current_password, new_password)
    errors.add(:current_password, I18n.t('errors.messages.is_wrong')) if current_password.present? && !self&.authenticate(current_password)
    errors.add(:current_password, I18n.t('errors.messages.blank')) if current_password.blank?
    errors.add(:password, I18n.t('errors.messages.blank')) if new_password.blank?
  end

  # callback
  before_validation { email.downcase! }
  before_update :last_admin_user_update?
  before_destroy :last_admin_user_destroy?

  private

  def last_admin_user_update?
    admin_users = User.where(admin: true)
    if admin_users.count == 1 && admin_users.first == self && !admin
      errors.add(:admin, :minimum_required)
      throw :abort
    else
      true
    end
  end

  def last_admin_user_destroy?
    throw :abort if User.where(admin: true).count == 1 && admin
  end
end
