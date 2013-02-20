require 'test_helper'

class VertexTest < ActiveSupport::TestCase

should validate_presence_of(:lat)
should validate_presence_of(:lng)
should belong_to(:building)
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

