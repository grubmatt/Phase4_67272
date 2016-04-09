class Shift < ActiveRecord::Base
  before_destroy :can_be_destroyed?

  has_many :shift_jobs
  has_many :jobs, through: :shift_jobs
  belongs_to :assignment

  validates_presence_of :date, :start_time, :assignment_id
  validates_time :end_time, :after => :start_time, :after_message => 'must be after start_time', allow_blank: true
  validates_date :date, :on_or_after => Date.current, on: :create
  validate :assignment_is_active_in_system, on: :create

  scope :completed,     -> { joins(:shift_jobs).where("shift_id = ?", self.id) }
  scope :incompleted,   -> { joins(:shift_jobs).where("shift_id = ?", self.shift_id)}
  scope :for_store,     -> (store_id) { joins(:assignment).where("store_id = ?", store_id) }
  scope :for_employee,  -> (employee_id) { joins(:assignment).where("employee_id = ?", employee_id) }
  scope :past,          -> { where("date < ?", Date.current) }
  scope :upcoming,      -> { where("date >= ?", Date.current) }
  scope :for_next_days, -> (next_days) { where("date >= ? & date < ?", Date.current, Date.current + next_days) }
  scope :for_past_days, -> (past_days) { where("date < ? & date >= ?", Date.current, Date.current - past_days) }
  scope :chronological, -> { order('date ASC') }
  scope :by_store,      -> { joins(:assignment).joins(:store).order("name") }
  scope :by_employee,   -> { joins(:assignment).joins(:employee).order("last_name, first_name") }

  def completed?
    return false unless self.shift_jobs.to_a.size != 0
  end

  def start_now
  	self.start_time = Time.now
  	self.save
  end

  def end_now
  	self.end_time = Time.now
  	self.save
  end

  private
  def assignment_is_active_in_system
  	all_active_assignments = Assignment.current.map{|i| i.id}
    unless all_active_assignments.include?(self.assignment_id)
      errors.add(:assignment_id, "is not an active assignment at the creamery")
    end
  end

  def can_be_destroyed?
    return false unless self.date >= Date.current
  end
end
