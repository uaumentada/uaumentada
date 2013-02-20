class CreateAdsPoints < ActiveRecord::Migration
  def self.up
    create_table :ads_points do |t|
      t.string :title
      t.float :lat
      t.float :lng
      t.integer :campus_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ads_points
  end
end
