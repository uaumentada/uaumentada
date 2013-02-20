# == Schema Information
#
# Table name: market_items
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  price       :integer
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  campus_id   :integer
#  university_id   :integer
#


class MarketItem < ActiveRecord::Base

	belongs_to :user 
	belongs_to :campus
	

	validates :title, :presence => true
	validates :price, :presence => true
	validates :user, :presence => true

def self.search(search)
 if search
   
    where('title LIKE ?', "%#{search}%")
  else
    scoped
  end
end

end


