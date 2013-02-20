class AddIconToCategoryAndPoiType < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.has_attached_file :icon
    end
    
    change_table :poi_types do |t|
      t.has_attached_file :icon
    end
    
  end

  def self.down
    drop_attached_file :categories, :icon
    drop_attached_file :poi_types, :icon
  end
end
