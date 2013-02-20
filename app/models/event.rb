class Event < ActiveRecord::Base

belongs_to :campus
has_and_belongs_to_many :ads_points

belongs_to :category
belongs_to :user

has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }


  validates_attachment_size :image, :less_than => 2.megabytes, :message => "La imagen debe pesar menos de 2MB"
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png'], :message => "La imagen no tiene un formato valido, debe ser jpeg o png"

validates_presence_of :lat, :presence => { :message => "Debe escoger un punto en el mapa" }
validates_presence_of :title, :presence => {:message => 'Debe indicar un titulo' }
validates_presence_of :init_date
validates_presence_of :end_date
validates_presence_of :category_id
validates_presence_of :campus_id
validates_presence_of :user_id


#Geocode https://github.com/alexreisner/geocoder
geocoded_by :address, :latitude  => :lat, :longitude => :lng # ActiveRecord
#  after_validation :geocode
validate :date_validation
def date_validation
  if self[:end_date] < self[:init_date]
    errors[:end_date] << "La fecha y hora final debe ser posterior a la fecha inicial"
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
# Table name: events
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  description :text
#  lat         :float(255)
#  lng         :float(255)
#  campus_id   :integer
#  category_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  title       :string(255)
#  init_date   :datetime
#  end_date    :datetime
#

