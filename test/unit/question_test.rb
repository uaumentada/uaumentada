# == Schema Information
#
# Table name: questions
#
#  id              :integer         not null, primary key
#  question_type   :integer
#  question        :string(255)
#  mandatory       :boolean
#  help            :string(255)
#  answers         :string(255)
#  question_number :integer
#  survey_id       :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

should validate_presence_of(:survey_id)
should have_many(:answers)
should belong_to(:survey)

end
