class ChangePoiType < ActiveRecord::Migration
  def self.up
	remove_column :pois, :poi_type
	add_column :pois, :poi_type_id, :integer
  end

  def self.down
	remove_column :pois, :poi_type_id
	add_column :pois, :poi_type, :integer
  end
end
