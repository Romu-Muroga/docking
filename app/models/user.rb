class User < ApplicationRecord
  # validates
  before_validation { email.downcase! }#downcase!でバリデーションする前にメールアドレスの値を小文字に変換
  validates :name, presence: true, length: { in: 1..500 }
  validates :email,
            presence: true,
            length: { in: 1..500 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: true
  validates :password, presence: true, length: { in: 6..100 }
  validates :admin, presence: true

  has_secure_password
  # セキュアにハッシュ化したパスワードを、データベース内のpassword_digestというカラムに保存する
  # 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。また、存在性と値が一致するかどうかのバリデーションも追加される
  # authenticateメソッドが使えるようになる (引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド)

  # association
  has_one :picture, as: :imageable, dependent: :destroy# TODO: foreign_key: { on_delete: :cascade }
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :iine_posts, through: :likes, source: :post#「ユーザーがいいねをしたポストの一覧」という関連
  has_many :comments, dependent: :destroy
end
