class IndoorMap < ActiveRecord::Base
  
  belongs_to :building
  
  has_attached_file :image, :styles => { :medium => "300x300>", :small => "200x200#", :thumb => "100x100#" }
end

# == Schema Information
#
# Table name: indoor_maps
#
#  id                 :integer         not null, primary key
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  floor              :integer
#  building_id        :integer
#  created_at         :datetime
#  updated_at         :datetime
#

