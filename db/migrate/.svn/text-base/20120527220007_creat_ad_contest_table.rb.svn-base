class CreatAdContestTable < ActiveRecord::Migration
def self.up
    
    create_table 'ads_points_contests', :id => false do |t|
      t.column 'contest_id', :integer
      t.column 'ads_point_id', :integer
    end
    
  end

  def self.down
    drop_table 'ads_points_contests'
  end
end
