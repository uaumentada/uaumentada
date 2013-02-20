require 'test_helper'

class TokenTest < ActiveSupport::TestCase

should validate_presence_of(:platform)
should validate_presence_of(:phone_id)
end

# == Schema Information
#
# Table name: tokens
#
#  id         :integer         not null, primary key
#  phone_id   :string(255)
#  platform   :string(255)
#  last_lat   :float
#  last_lng   :float
#  created_at :datetime
#  updated_at :datetime
#

