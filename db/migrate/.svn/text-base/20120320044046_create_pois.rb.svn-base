class CreatePois < ActiveRecord::Migration
  def self.up
    create_table :pois do |t|
      t.string :name
      t.float :lat
      t.float :lng
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :pois
  end
end
