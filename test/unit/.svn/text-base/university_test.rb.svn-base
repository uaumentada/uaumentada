require 'test_helper'

class UniversityTest < ActiveSupport::TestCase
  # Replace this with your real tests.
 def setup
   @university = universities(:one)
end

should validate_presence_of(:name)
should validate_presence_of(:email)
should validate_uniqueness_of(:email)
should have_many(:users)
end
