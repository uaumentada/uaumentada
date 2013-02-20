class ChangeLatLngTypeVertex < ActiveRecord::Migration
  def self.up
    change_column :vertices, :lat, :string
  change_column :vertices, :lng, :string
  end

  def self.down
  change_column :vertices, :lat, :float
  change_column :vertices, :lng, :float
  end
end
