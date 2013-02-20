class AddLatandLongToCampus < ActiveRecord::Migration
  def self.up
	add_column :campus, :lat, :string
	add_column :campus, :lng, :string

  end

  def self.down
	remove_column :campus, :lat
	remove_column :campus, :lng
  end
end
