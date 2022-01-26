class Platform < ApplicationRecord
  has_many :trade_platforms
  has_many :trades, through: :trade_platforms
end
