class AdsPoint < ActiveRecord::Base

validates_presence_of :title
validates_presence_of :lat
validates_presence_of :campus_id

has_and_belongs_to_many :events
has_and_belongs_to_many :contests
belongs_to :campus

#Geocode https://github.com/alexreisner/geocoder
geocoded_by :address, :latitude  => :lat, :longitude => :lng # ActiveRecord

end
