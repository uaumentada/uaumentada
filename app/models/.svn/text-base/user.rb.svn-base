# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  password   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	#attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation
  validates_confirmation_of :password
	#email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, :presence => true
  validates :email, :presence   => true
                    #:format     => { :with => email_regex },
                    #:uniqueness => {:case_sensitive => false}

validates_uniqueness_of :email, :scope => [:university_id] #unique within a university
#validates_uniqueness_of :university_id, :scope => [:email]
	#validates :password, :presence     => true,
   #                  	     :confirmation => true,
    #                         :length       => { :within => 6..40 }

  has_and_belongs_to_many :privileges, :select => "DISTINCT privileges.*"
  #before destroy { privileges.clear } #will clear the join table of all entries of that User

	#has_many :user_courses, dependent: :destroy
  has_many :courses, dependent: :destroy#, :through => :user_courses

	has_many :market_items, dependent: :destroy 

	has_one :professor, dependent: :destroy 
	
	has_many :surveys, dependent: :destroy
	
	has_many :push_messages, dependent: :destroy 
	
	has_many :contests, dependent: :destroy 
	
	has_many :pois, dependent: :destroy
	
	has_many :events, dependent: :destroy
	
	has_many :answers, dependent: :destroy
	
	belongs_to :university
	
end
