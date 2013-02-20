class CreateIndoorMaps < ActiveRecord::Migration
  def self.up
    create_table :indoor_maps do |t|
      t.has_attached_file :image
      t.integer :floor
      t.integer :building_id

      t.timestamps
    end
  end

  def self.down
    drop_table :indoor_maps
  end
end
