require 'test_helper'

class CourseTest < ActiveSupport::TestCase

should validate_presence_of(:initials)
should validate_presence_of(:title)
should validate_presence_of(:user_id)

end