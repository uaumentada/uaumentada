class CreateMarketItems < ActiveRecord::Migration
  def self.up
    create_table :market_items do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :market_items
  end
end
