class Vertex < ActiveRecord::Base

  belongs_to :building

  validates :lat, :presence => true 
  validates :lng, :presence => true 

end

# == Schema Information
#
# Table name: vertices
#
#  id          :integer         not null, primary key
#  building_id :integer
#  lat         :float
#  lng         :float
#  created_at  :datetime
#  updated_at  :datetime
#

