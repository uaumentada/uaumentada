require 'test_helper'

class ContestTest < ActiveSupport::TestCase

should validate_presence_of(:title)
should validate_presence_of(:organizer)
should validate_presence_of(:user_id)
should validate_presence_of(:init_date)
should validate_presence_of(:end_date)

end

# == Schema Information
#
# Table name: contests
#
#  id                 :integer         not null, primary key
#  user_id            :integer
#  title              :string(255)
#  description        :text
#  init_date          :datetime
#  end_date           :datetime
#  organizer          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

