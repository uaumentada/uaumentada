class AddCampusToPoi < ActiveRecord::Migration
  def self.up
    add_column :pois, :campus_id, :integer
  end

  def self.down
    remove_column :pois, :campus_id
  end
end
