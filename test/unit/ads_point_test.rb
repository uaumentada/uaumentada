require 'test_helper'

class AdsPointTest < ActiveSupport::TestCase

should validate_presence_of(:title)
should validate_presence_of(:lat)
should validate_presence_of(:campus_id)

end
