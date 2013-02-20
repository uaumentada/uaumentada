class AddInitDateToMenu < ActiveRecord::Migration
  def self.up
    add_column :menus, :init_date, :datetime
  end

  def self.down
    remove_column :menus, :init_date
  end
end
