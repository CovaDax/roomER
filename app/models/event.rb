class Event < ActiveRecord::Base
  attr_accessible :end_at, :name, :start_at, :organization, #:room, 
  :room_id, :approved, :numAttendees
  has_event_calendar
  #has_one :room      #which is better, has one or belongs to?
  belongs_to :room
  
  validates :name, :organization, :room_id,  presence: true
  validates :numAttendees, :presence => { :message => "cannot be empty"}
  validates :numAttendees, :inclusion => { :in => 1..300, :message => "less than 300 please." }  
end
