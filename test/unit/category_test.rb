require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

should validate_presence_of(:name)

end

# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

