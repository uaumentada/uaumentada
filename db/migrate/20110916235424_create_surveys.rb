class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.string :title
      t.integer :privacy_level
      t.string :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :surveys
  end
end
