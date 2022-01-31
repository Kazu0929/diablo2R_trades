class CreateUserPlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :user_platforms do |t|
      t.references :user, foreign_key: true
      t.references :platform, foreign_key: true

      t.timestamps
    end
  end
end
