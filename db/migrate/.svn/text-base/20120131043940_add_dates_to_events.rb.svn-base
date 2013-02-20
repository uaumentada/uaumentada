class AddDatesToEvents < ActiveRecord::Migration
  def self.up

   add_column :events, :init_date, :datetime
   add_column :events, :end_date, :datetime

  end

  def self.down
    remove_column :events, :init_date
    remove_column :events, :end_date
  end
end
