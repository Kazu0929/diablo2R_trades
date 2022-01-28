class Trade < ApplicationRecord

  belongs_to :user
  has_many :trade_platforms, dependent: :destroy
  has_many :platforms, through: :trade_platforms

  #最新順に取得
  default_scope -> { order(created_at: :desc) }
  #enumで値を定義
  enum mode: [:Softcore, :Hardcore]
  enum season: [:Normal, :Ladder]
  enum trade_type: [:Buy, :Sell]
  #バリデーション
  validates :user_id, presence: true
  validates :mode, presence: true
  validates :season, presence: true
  validates :trade_type, presence: true
  validates :item_to_want, presence: true
  validates :item_to_offer, presence: true
  validates :content, length: { maximum: 140 }

  class << self
    def search(id,trade_type, item)
      #トレードタイプで検索条件変更
      if trade_type == "Buy"
        where.not(user_id: id).where(trade_type: trade_type, item_to_want: item)
      else
        where.not(user_id: id).where(trade_type: trade_type, item_to_offer: item)
      end
    end
  end
end
