class Event < ActiveRecord::Base
  attr_accessible :end_at, :name, :start_at, :organization, :room_id, :contactName, :email, :numAttends, :eventName, :approved, :notes, :contactPhone, :contactEmail
  attr_writer :current_step
  has_event_calendar
  #has_one :room      #which is better, has one or belongs to?
  belongs_to :room
  validates_presence_of :name,:organization,:numAttends, :if => lambda{|o| o.current_step == "first"}
  validates :numAttends, :numericality => {:greater_than => 0}, :if => lambda{|o| o.current_step == "first"}
  #validate :sensible_datetime?  Does not work with MultiStep form
  validates_presence_of :contactName, :contactPhone, :if => lambda{|o| o.current_step == "fourth"}
  validates :contactEmail,   
            :presence => true,   
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }   ,
         	:if  => lambda{|o| o.current_step == "fourth"}
  
  def sensible_datetime?
  if self.start_at > self.end_at
      errors.add(:ends_at, 'must be after start time')
    end
  end


  


  def steps
    %w[first second third fourth]
  end

  def current_step
    @current_step || steps.first
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def first?
    current_step == "first"
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
