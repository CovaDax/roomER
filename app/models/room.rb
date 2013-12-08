class Room < ActiveRecord::Base
	attr_accessible :building, :maxOccupancy, :number
	has_many :events
	
   validates :building, :maxOccupancy, :number, presence: true
	
	
	def name		#this concatenates and returns as :name
  		[building, number].join(' ')
  end
  
  
  def choiceName   #concatenates room, number, & maxOccucpancy
  		#[building, number, '   <', maxOccupancy, '>'].join(' ') #join doesn't honor spaces
  		"#{self.building} #{self.number}:   <holds #{self.maxOccupancy}>"
  end


end
