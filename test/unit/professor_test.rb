require 'test_helper'

class ProfessorTest < ActiveSupport::TestCase
  should validate_presence_of(:user_id)
  should validate_uniqueness_of(:user_id)
  should belong_to(:user)
  should belong_to(:poi)
end

# == Schema Information
#
# Table name: professors
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  status     :boolean         default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  poi_id     :integer
#  approved   :boolean         default(FALSE)
#

