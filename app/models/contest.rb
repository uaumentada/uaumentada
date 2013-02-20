class Contest < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :ads_points

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment_size :image, :less_than => 2.megabytes, :message => "La imagen debe pesar menos de 2MB"
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png'], :message => "La imagen no tiene un formato valido, debe ser jpeg o png"
  
  validates_presence_of :title
  validates_presence_of :organizer
  validates_presence_of :user_id
  validates_presence_of :init_date
  validates_presence_of :end_date

validate :date_validation
def date_validation
  if self[:end_date] < self[:init_date]
    errors[:end_date] << "La fecha final debe ser posterior a la fecha inicial"
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

def self.search(search)
 if search
   
    where('title LIKE ?', "%#{search}%")
  else
    scoped
  end
end

end

# == Schema Information
#
# Table name: contests
#
#  id                 :integer         not null, primary key
#  user_id            :integer
#  title              :string(255)
#  description        :text
#  init_date          :datetime
#  end_date           :datetime
#  organizer          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

