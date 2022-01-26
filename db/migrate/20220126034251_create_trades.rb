class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :mode, null:false, default: 0
      t.integer :season, null:false, default: 0
      t.integer :trade_type, null:false, default: 0
      t.string :item_to_want
      t.string :item_to_offer
      t.text :content

      t.timestamps
    end
    add_index :trades, [:user_id, :created_at]
  end
end
