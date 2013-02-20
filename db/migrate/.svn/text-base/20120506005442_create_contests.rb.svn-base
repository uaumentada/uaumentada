class CreateContests < ActiveRecord::Migration
  def self.up
    create_table :contests do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.datetime :init_date
      t.datetime :end_date
      t.string :organizer
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :contests
  end
end
