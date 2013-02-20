class CreatePushMessages < ActiveRecord::Migration
  def self.up
    create_table :push_messages do |t|
      t.integer :user_id
      t.text :message

      t.timestamps
    end
  end

  def self.down
    drop_table :push_messages
  end
end
