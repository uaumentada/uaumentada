class AddUserIdToPrivilege < ActiveRecord::Migration
  def self.up
    add_column :privileges, :user_id, :integer
  end

  def self.down
    remove_column :privileges, :user_id
  end
end
