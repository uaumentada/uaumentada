class PushMessage < ActiveRecord::Base

  belongs_to :user
  validates :user, :presence => true

  validates :message, :presence => true

end

# == Schema Information
#
# Table name: push_messages
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#  sent       :boolean
#

