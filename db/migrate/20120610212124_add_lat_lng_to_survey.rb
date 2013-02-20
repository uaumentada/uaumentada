class AddLatLngToSurvey < ActiveRecord::Migration
  def self.up
    add_column :surveys, :lat, :float
    add_column :surveys, :lng, :float
  end

  def self.down
    remove_column :surveys, :lat
    remove_column :surveys, :lng
  end
end
