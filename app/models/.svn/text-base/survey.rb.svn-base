class Survey < ActiveRecord::Base


validates :title, :presence => true 
validates :privacy_level, :presence => true
validates_presence_of :user_id
validates_presence_of :code
validates_uniqueness_of :code
validates :course_id, :presence => {:message => "Debes seleccionar un curso"}, :if => Proc.new { |u| u.privacy_level == 1}

has_many :questions, dependent: :destroy
has_many :answers, dependent: :destroy
belongs_to :user
belongs_to :university

#Geocode https://github.com/alexreisner/geocoder
geocoded_by :address, :latitude  => :lat, :longitude => :lng # ActiveRecord
#  after_validation :geocode

def self.search(search)
 if search
   
    where('title LIKE ?', "%#{search}%")
  else
    scoped
  end
end 

def self.privacy
	{'Curso'=>1, 'Codigo' => 2, 'Publica' => 3, 'Geolocalizada'=> 4, 'AlumnosCerrada'=> 5, 'CodigoCerrada' => 6, 'PublicaCerrada' => 7, 'GeolocalizadaCerrada' => 8}
end

def self.close
  5 #index of privacy indicating the survey is closed
end



 before_validation :create_code, :on => :create
 
  def create_code
    self.code = rand(36**8).to_s(36) if self.new_record? and self.code.nil?
  end 

end

# == Schema Information
#
# Table name: surveys
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  privacy_level :integer
#  user_id       :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  course_id     :integer
#

