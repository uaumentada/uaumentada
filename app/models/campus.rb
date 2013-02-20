class Campus < ActiveRecord::Base

  set_table_name 'campus'

  validates_presence_of :name
  validates_presence_of :university_id

  has_many :pois, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :market_items, dependent: :destroy
  has_many :ads_points, dependent: :destroy
  belongs_to :university
end

# == Schema Information
#
# Table name: campus
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  lat        :string(255)
#  lng        :string(255)
#

