class AddUserIdToPois < ActiveRecord::Migration
  def self.up
    
    add_column :pois, :user_id, :integer
  end

  def self.down
        remove_column :pois, :user_id
  end
end
