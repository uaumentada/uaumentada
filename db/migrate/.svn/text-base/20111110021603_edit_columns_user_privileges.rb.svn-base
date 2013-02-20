class EditColumnsUserPrivileges < ActiveRecord::Migration
  def self.up
	remove_column :user_privileges, :email
	remove_column :user_privileges, :id_priv
	add_column :user_privileges, :user_id, :integer
	add_column :user_privileges, :privilege_id, :integer

  end

  def self.down
	add_column :user_privileges, :email, :string
	add_column :user_privileges, :id_priv, :integer
	remove_column :user_privileges, :user_id
	remove_column :user_privileges, :privilege_id
  end
end
