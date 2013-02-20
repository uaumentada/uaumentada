class Token < ActiveRecord::Base

  validates :phone_id,
    :presence => true,
    :uniqueness => true
  validates :platform,
    :presence => true
  validates :university_id,
    :presence => true
    
    belongs_to :university

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

