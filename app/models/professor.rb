class Professor < ActiveRecord::Base

belongs_to :user
belongs_to :poi

validates :user_id, :presence  => true,
                 :uniqueness => true

end

# == Schema Information
#
# Table name: professors
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  status     :boolean         default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  poi_id     :integer
#  approved   :boolean         default(FALSE)
#

