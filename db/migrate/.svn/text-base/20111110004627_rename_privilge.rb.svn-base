class RenamePrivilge < ActiveRecord::Migration
  def self.up

	rename_table :user_priviledges, :user_privileges
  end

  def self.down
	rename_table :user_privileges, :user_priviledges
  end
end
