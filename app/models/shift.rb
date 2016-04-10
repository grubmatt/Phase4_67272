class Shift < ActiveRecord::Base
  before_destroy :can_be_destroyed?
  after_create :set_end_time

  has_many :shift_jobs
  has_many :jobs, through: :shift_jobs
  belongs_to :assignment
  has_one :store, through: :assignment
  has_one :employee, through: :assignment


  validates_presence_of :date, :start_time, :assignment_id
  validates_time :end_time, :after => :start_time, :after_message => 'must be after start_time', allow_blank: true
  validates_date :date, :on_or_after => Date.current, on: :create
  validate :assignment_is_active_in_system, on: :create

  scope :completed,     -> { joins(:shift_jobs) }
  scope :incompleted,   -> { leftjoins(:shift_jobs)}
  scope :for_store,     -> (store_id) { joins(:assignment).where("store_id = ?", store_id) }
  scope :for_employee,  -> (employee_id) { joins(:assignment).where("employee_id = ?", employee_id) }
  scope :past,          -> { where("date < ?", Date.current) }
  scope :upcoming,      -> { where("date >= ?", Date.current) }
  scope :for_next_days, -> (next_days) { where("date between ? and ?", Date.current, Date.current + next_days) }
  scope :for_past_days, -> (past_days) { where("date between ? and ?", Date.current - past_days, Date.current - 1) }
  scope :chronological, -> { order('date ASC') }
  scope :by_store,      -> { joins(:store).order("stores.name") }
  scope :by_employee,   -> { joins(:employee).order("employees.last_name, employees.first_name") }

  def completed?
    return false unless self.shift_jobs.to_a.size != 0
  end

  def start_now
  	#self.update_attribute(:start_time, Time.now)
    self.start_time = Time.now
    self.save
  end

  def end_now
    #self.update_attribute(:end_time, Time.now)
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

  def set_end_time
    self.end_time ||= self.start_time + 3.hours
    self.save
  end
end
