class ChangeColumnEvents < ActiveRecord::Migration
  def self.up

	change_column :events, :lat, :float
	change_column :events, :lng, :float
  end

  def self.down

	change_column :events, :lat, :string
	change_column :events, :lng, :string
  end
end
