class RemoveIdFromUserPrivilege < ActiveRecord::Migration
  def self.up
    
    create_table 'privileges_users', :id => false do |t|
      t.column 'user_id', :integer
      t.column 'privilege_id', :integer
    end
    
  end

  def self.down
     
     drop_table 'privileges_users'
    
  end
end
