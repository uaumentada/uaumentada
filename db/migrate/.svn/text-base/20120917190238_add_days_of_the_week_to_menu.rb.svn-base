class AddDaysOfTheWeekToMenu < ActiveRecord::Migration
  def self.up
    add_column :menus, :monday, :boolean
    add_column :menus, :tuesday, :boolean
    add_column :menus, :wednesday, :boolean
    add_column :menus, :thursday, :boolean
    add_column :menus, :friday, :boolean
    add_column :menus, :saturday, :boolean
    add_column :menus, :sunday, :boolean
  end

  def self.down
    remove_column :menus, :sunday
    remove_column :menus, :saturday
    remove_column :menus, :friday
    remove_column :menus, :thursday
    remove_column :menus, :wednesday
    remove_column :menus, :tuesday
    remove_column :menus, :monday
  end
end
