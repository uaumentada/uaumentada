class AddActiveToToken < ActiveRecord::Migration
  def self.up
    add_column :tokens, :active, :boolean, :default => true
    add_column :tokens, :university_id, :integer
  end

  def self.down
    remove_column :tokens, :active
    remove_column :tokens, :university_id
  end
end
