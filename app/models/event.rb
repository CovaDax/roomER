class Event < ActiveRecord::Base
  attr_accessible :end_at, :name, :start_at, :organization, :room_id, :contactName, :email, :numAttends, :eventName
  attr_writer :current_step
  has_event_calendar
  #has_one :room      #which is better, has one or belongs to?
  belongs_to :room
  validates_presence_of :name,:organization,:numAttends, :if => lambda{|o| o.current_step == "first"}
  validates :numAttends, :numericality => {:greater_than => 0}


  def steps
    %w[first second third]
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
