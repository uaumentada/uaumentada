class Menu < ActiveRecord::Base
  
  belongs_to :poi
  
  validates_presence_of  :title
  validates_presence_of  :price
  validates_presence_of  :poi_id
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates_attachment_size :image, :less_than => 2.megabytes, :message => "La imagen debe pesar menos de 2MB"
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png'], :message => "La imagen no tiene un formato valido, debe ser jpeg o png"

  validate :date_validation
  def date_validation
    if self[:date] < self[:init_date]
      errors[:date] << "La fecha final debe ser posterior a la fecha inicial"
      return false
    else
      return true
    end
  end
  
  validate :init_date_validation
def init_date_validation
  #if self[:init_date] < Date.today
   # errors[:init_date] << "La fecha y hora de inicio debe ser igual o posterior a la fecha de hoy"
    #return false
  #else
    return true
  #end
end
  
end

# == Schema Information
#
# Table name: menus
#
#  id                 :integer         not null, primary key
#  title              :string(255)
#  description        :text
#  poi_id             :integer
#  date               :datetime
#  price              :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

