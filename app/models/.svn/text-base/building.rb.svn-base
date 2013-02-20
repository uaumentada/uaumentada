class Building < ActiveRecord::Base
  
  validates_presence_of :poi_id
  
  belongs_to :poi
  has_many :indoor_maps, dependent: :destroy
  has_many :vertices, dependent: :destroy
end

# == Schema Information
#
# Table name: buildings
#
#  id         :integer         not null, primary key
#  floors     :integer
#  poi_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

