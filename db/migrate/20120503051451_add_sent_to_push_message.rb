class AddSentToPushMessage < ActiveRecord::Migration
  def self.up
    add_column :push_messages, :sent, :boolean
  end

  def self.down
    remove_column :push_messages, :sent
  end
end
