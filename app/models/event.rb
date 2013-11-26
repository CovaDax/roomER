class Event < ActiveRecord::Base
  attr_accessible :end_at, :name, :start_at, :organization, #:room, 
  :room_id
  has_event_calendar
  #has_one :room      #which is better, has one or belongs to?
  belongs_to :room
end
