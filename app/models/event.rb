class Event < ActiveRecord::Base
  attr_accessible :name, :organization, :start_at, :end_at, :room_id, :contactName,
                  :email, :numAttends, :eventName, :approved, :notes, :status
	#warning do not remove email. why? dunno something is tagged to it.
  attr_writer :current_step
  has_event_calendar
  #has_one :room      #which is better, has one or belongs to?
  belongs_to :room

  validates_presence_of :name,:organization,:numAttends, :if => lambda{|o| o.current_step == "first"}
  validates :numAttends, :numericality => {:greater_than => 0}, :if => lambda{|o| o.current_step == "first"}
  #validate :sensible_datetime?  Does not work with MultiStep form
  validates_presence_of :contactName, :contactPhone, :if => lambda{|o| o.current_step == "fourth"}
  
  attr_accessible  :contactEmail
  validates :contactEmail,   
            :presence => true,   
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }   ,
         	:if  => lambda{|o| o.current_step == "fourth"}
  def approved?
    status=='approved'
  end

  attr_accessible  :contactPhone
  validates_format_of :contactPhone,
      :message => "must be a valid telephone number.",
      :with => /^[\(\)0-9\- \+\.]{10,20} *[extension\.]{0,9} *[0-9]{0,5}$/,
          	:if  => lambda{|o| o.current_step == "fourth"}
     
	attr_accessible :terms_and_conditions
	validates_acceptance_of :terms_and_conditions, 
	:on => :create, :message => "must be accepted."

  
  def sensible_datetime?
  if self.start_at > self.end_at
      errors.add(:ends_at, 'must be after start time')
    end
  end


  module Status
    PENDING = 'pending'
    APPROVED = 'approved'
    DENIED = 'denied'
    CANCELED  = 'canceled'
  end

STATUSES = [ Status::PENDING, Status::APPROVED, Status::DENIED, Status::CANCELED ]
  validates :status, :inclusion => { :in => STATUSES, :message => "%{value} is not a valid status value" },  :presence => true, :if => lambda{|o| o.current_step == "fourth"}
  


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

  def getEmail
    contactEmail
  end
end
