# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  password   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
 
 def setup
   @user = users(:one)
end
should validate_presence_of(:name)
should validate_presence_of(:email)
should validate_uniqueness_of(:email)
should have_and_belong_to_many(:privileges)
should have_many(:user_courses)
should have_many(:courses)
should have_many(:market_items)
should have_one(:professor)
should have_many(:surveys)
should have_many(:push_messages)
should have_many(:contests)
should have_many(:pois)
should have_many(:events)
should have_many(:answers)
should belong_to(:university)

  
end
