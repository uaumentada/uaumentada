require 'test_helper'

class PoiTest < ActiveSupport::TestCase

should validate_presence_of(:name)
should validate_presence_of(:lat)
should validate_presence_of(:lng)
should validate_presence_of(:poi_type_id)
should validate_presence_of(:user_id)
should validate_presence_of(:campus_id)

end

# == Schema Information
#
# Table name: pois
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  lat         :float
#  lng         :float
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  poi_type_id :integer
#  campus_id   :integer
#  user_id     :integer
#

