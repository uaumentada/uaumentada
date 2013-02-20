class Answer < ActiveRecord::Base

validates_presence_of :survey_id
validates_presence_of :user_id
validates_presence_of :question_id
validates_presence_of :answer

belongs_to :survey
belongs_to :user
belongs_to :question

end

# == Schema Information
#
# Table name: answers
#
#  id          :integer         not null, primary key
#  answer      :text
#  created_at  :datetime
#  updated_at  :datetime
#  group       :integer
#

