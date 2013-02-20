class ChangeDinerIdInMenu < ActiveRecord::Migration
  def self.up
    rename_column :menus, :diner_id, :poi_id
  end

  def self.down
    rename_column :menus,  :poi_id, :diner_id
  end
end
