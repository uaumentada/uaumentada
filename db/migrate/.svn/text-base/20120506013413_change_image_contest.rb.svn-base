class ChangeImageContest < ActiveRecord::Migration
  def self.up
  
  remove_column :contests, :image
  
  change_table :contests do |t|
      t.has_attached_file :image
    end
  
  end

  def self.down
  
  drop_attached_file :contests, :image
  add_column :contests, :image, :string
  
  end
end
