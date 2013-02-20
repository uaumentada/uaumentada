class Course < ActiveRecord::Base

validates_presence_of :user_id
validates_presence_of :initials
validates_presence_of :title

    #has_many :user_courses, dependent: :destroy
    belongs_to :user #, :through => :user_courses

end

# == Schema Information
#
# Table name: courses
#
#  id         :integer         not null, primary key
#  initials   :string(255)
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

