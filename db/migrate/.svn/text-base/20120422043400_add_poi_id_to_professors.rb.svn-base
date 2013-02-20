class AddPoiIdToProfessors < ActiveRecord::Migration
  def self.up
    add_column :professors, :poi_id, :integer
    add_column :professors, :approved, :boolean, :default => false
  end

  def self.down
    remove_column :professors, :poi_id
    remove_column :professors, :approved, :boolean , :default => nil
  end
end
