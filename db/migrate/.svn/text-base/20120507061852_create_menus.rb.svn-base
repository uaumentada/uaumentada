class CreateMenus < ActiveRecord::Migration
  def self.up
    create_table :menus do |t|
      t.string :title
      t.text :description
      t.integer :diner_id
      t.datetime :date
      t.integer :price
      t.has_attached_file :image

      t.timestamps
    end
  end

  def self.down
    drop_table :menus
  end
end
