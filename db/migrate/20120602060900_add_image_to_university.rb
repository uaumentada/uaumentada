class AddImageToUniversity < ActiveRecord::Migration
  def self.up
    change_table :universities do |t|
      t.has_attached_file :image
    end
  end

  def self.down
    drop_attached_file :universities, :image
  end
end
