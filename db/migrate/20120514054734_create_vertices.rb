class CreateVertices < ActiveRecord::Migration
  def self.up
    create_table :vertices do |t|
      t.integer :building_id
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end

  def self.down
    drop_table :vertices
  end
end
