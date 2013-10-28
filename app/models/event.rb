class Event < ActiveRecord::Base
  attr_accessible :end_at, :name, :start_at, :organization
  has_event_calendar
end
