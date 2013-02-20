class Category < ActiveRecord::Base

validates_presence_of :name

has_many :events, dependent: :destroy

has_attached_file :icon, :styles => { :high => "48x48>", :medium => "32x32>", :low => "24x24"}

end

# == Schema Information
#
# Table name: categories
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

