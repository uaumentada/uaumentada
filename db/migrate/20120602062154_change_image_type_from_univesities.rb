class ChangeImageTypeFromUnivesities < ActiveRecord::Migration
  def self.up
    
    drop_table :universities
    
    create_table :universities do |t|
      t.string :name
      t.string :mail
      t.has_attached_file :image

      t.timestamps
    end
    
  end

   def self.down
    drop_table :universities
    
    create_table :universities do |t|
      t.string :name
      t.string :mail

      t.timestamps
    end
  end
end
