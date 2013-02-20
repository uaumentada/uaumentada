require 'test_helper'

class CampusTest < ActiveSupport::TestCase

should validate_presence_of(:name)
should validate_presence_of(:university_id)
end

# == Schema Information
#
# Table name: campus
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  lat        :string(255)
#  lng        :string(255)
#

