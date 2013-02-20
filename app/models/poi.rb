class Poi < ActiveRecord::Base

has_one :professor, dependent: :nullify
has_one :menu, dependent: :destroy
has_one :building, dependent: :destroy

belongs_to :poi_type
belongs_to :campus
belongs_to :user

validates :lat, :presence => true 
validates :lng, :presence => true 
validates_presence_of :name, :presence => { :message => 'Debes indicar un Nombre' }
validates :poi_type_id, :presence => { :message => 'Debes seleccionar una categoria' }
validates_presence_of :campus_id
validates_presence_of :user_id

#Geocode https://github.com/alexreisner/geocoder
geocoded_by :address, :latitude  => :lat, :longitude => :lng # ActiveRecord
#  after_validation :geocode


def self.search(search)
 if search
   
    where('pois.name LIKE ?', "%#{search}%")
  else
    scoped
  end
end


end

# == Schema Information
#
# Table name: pois
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  lat         :float
#  lng         :float
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#  poi_type_id :integer
#  campus_id   :integer
#  user_id     :integer
#

