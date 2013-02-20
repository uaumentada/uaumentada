require 'test_helper'

class SurveyTest < ActiveSupport::TestCase

should validate_presence_of(:title)
should validate_presence_of(:privacy_level)
should validate_presence_of(:code)
should validate_uniqueness_of(:code)
should have_many(:questions)
should have_many(:answers)
should belong_to(:user)

end

# == Schema Information
#
# Table name: surveys
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  privacy_level :integer
#  user_id       :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  course_id     :integer
#

