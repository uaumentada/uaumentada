class AddPoiTypeToPoi < ActiveRecord::Migration
  def self.up
    add_column :pois, :poi_type, :integer
  end

  def self.down
    remove_column :pois, :poi_type
  end
end
