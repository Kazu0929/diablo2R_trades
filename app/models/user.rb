class User < ApplicationRecord
  before_save { email.downcase! }
  #nameカラムのバリデーション
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #emailカラムのバリデーション
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  #パスワードをハッシュ化　bcryptを使用
  has_secure_password
  #パスワードのバリデーション
  validates :password, presence: true, length: { minimum: 6 }
  #文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
             BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
