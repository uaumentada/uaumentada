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

class Question < ActiveRecord::Base


validates :survey_id, :presence => true 
validates_presence_of :question_type

belongs_to :survey
#set_table_name "questions"

end
