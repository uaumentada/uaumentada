class EditUniversityAndUsersColumns < ActiveRecord::Migration
  def self.up
    remove_column :universities, :user_id
    add_column :users, :university_id, :integer
    
  end

  def self.down
    add_column :universities, :user_id, :integer
    remove_column :users, :university_id
  end
end
