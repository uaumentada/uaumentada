class CreateTokens < ActiveRecord::Migration
  def self.up
    create_table :tokens do |t|
      t.integer :phone_id
      t.string :platform
      t.float :last_lat
      t.float :last_lng

      t.timestamps
    end
  end

  def self.down
    drop_table :tokens
  end
end
