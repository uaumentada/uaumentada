class Privilege < ActiveRecord::Base

   has_and_belongs_to_many :users
   
   #before destroy { users.clear } #will clear the join table of all entries of that Privilege

end

# == Schema Information
#
# Table name: privileges
#
#  id          :integer         not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#

