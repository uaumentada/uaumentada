class CreatAdEventTable < ActiveRecord::Migration
  def self.up
    
    create_table 'ads_points_events', :id => false do |t|
      t.column 'event_id', :integer
      t.column 'ads_point_id', :integer
    end
    
  end

  def self.down
    drop_table 'ads_points_events'
  end
end
