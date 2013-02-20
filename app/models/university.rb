class University < ActiveRecord::Base
  
  has_many :users, dependent: :destroy
  has_many :campuses, dependent: :destroy
  
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email
  
end


