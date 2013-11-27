class Room < ActiveRecord::Base
	attr_accessible :building, :maxOccupancy, :number
	has_many :events
	
   validates :building, :maxOccupancy, :number, presence: true
	
	
	def name		#this concatenates and returns as :name
  		[building, number].join(' ')
	end

end
