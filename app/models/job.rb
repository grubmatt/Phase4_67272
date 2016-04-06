class Job < ActiveRecord::Base
  has_many :shift_jobs
  has_many :shifts, through: :shift_jobs

  validates_presence_of :name

  scope :active,          -> { where(active: true) }
  scope :inactive,        -> { where(active: false) }
  scope :alphabetical,    -> { order('name') }

  # #before_detroy :check_association
  # after_rollback :make_inactive

  # private
  # def make_inactive
  # 	self.active = 0
  # end

  # def check_association
  # 	return false unless self.shift_jobs.size == 0
  # end
end
