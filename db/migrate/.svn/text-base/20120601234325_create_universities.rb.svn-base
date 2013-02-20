class CreateUniversities < ActiveRecord::Migration
  def self.up
    create_table :universities do |t|
      t.string :name
      t.string :mail
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :universities
  end
end
