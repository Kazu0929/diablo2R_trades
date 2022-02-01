class User < ApplicationRecord
  has_many :trades, dependent: :destroy
  has_many :user_platforms
  has_many :platforms, through: :user_platforms

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  attr_accessor :remember_token
  before_save { email.downcase! }
  #nameカラムのバリデーション
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #emailカラムのバリデーション
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  #パスワードをハッシュ化　bcryptを使用
  has_secure_password
  #パスワードのバリデーション
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  class << self
    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # 永続セッションのトークンを作成
    def new_token
      SecureRandom.urlsafe_base64
    end

    # マッチするアイテムを検索
    def find_match_items(user)
      #ユーザの使用プラットフォームを取得
      platform_ids = user.platforms.ids
      #モードを配列で取得
      user_mode = user.trades.pluck(:mode)
      #シーズンを配列で取得
      user_season = user.trades.pluck(:season)
      #欲しいアイテムを配列で取得
      user_trades_want = user.trades.pluck(:item_to_want)
      #提示するアイテムを配列で取得
      user_trades_offer = user.trades.pluck(:item_to_offer)
      #その他のユーザーの投稿を全て取得
      other_trades = Trade.where.not(user_id: user)
      #その他のユーザーの投稿から自分のアイテムとマッチする投稿を検索
      match_trades_without_platforms = other_trades.where(
        mode: user_mode, season: user_season,
        item_to_want: user_trades_offer,
        item_to_offer: user_trades_want,)

      #プラットフォームを設定してない場合は、アイテムのマッチングのみのデータを返す
      return match_trades_without_platforms if (platform_ids.blank?)
      #プラットフォームでの絞り込み結果を格納する配列を用意
      match_trades = []
      # マッチした投稿の中でユーザーの使用するプラットフォームが、 含まれる投稿のみを配列に追加
      match_trades_without_platforms.each do |trade|
        #マッチングした投稿のユーザーと自身のプラットフォームの配列に重複があるか確認
        match_platform = trade.user.platforms.ids & platform_ids
        #配列が空でなければ先ほど用意した配列にpush
        unless match_platform.empty?
          match_trades.push(trade)
        end
      end
      match_trades.uniq
    end
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

end
