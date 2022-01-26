class TradePlatform < ApplicationRecord
  belongs_to :trade
  belongs_to :platform
end
