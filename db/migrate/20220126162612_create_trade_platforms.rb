class CreateTradePlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :trade_platforms do |t|
      t.references :trade, index: true
      t.references :platform, index: true, foreign_key: true
      t.timestamps
    end
  end
end
