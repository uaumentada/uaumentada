class AddDefaultValueToStatusAttribute < ActiveRecord::Migration
  def self.up
    change_column :professors, :status, :boolean, :default => false
  end

  def self.down
    change_column :professors, :status, :boolean, :default => nil
  end
end
