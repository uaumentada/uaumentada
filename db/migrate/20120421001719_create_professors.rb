class CreateProfessors < ActiveRecord::Migration
  def self.up
    create_table :professors do |t|
      t.integer :user_id
      t.boolean :status

      t.timestamps
    end
  end

  def self.down
    drop_table :professors
  end
end
