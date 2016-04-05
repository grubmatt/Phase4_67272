class Job < ActiveRecord::Base
  has_many :shift_jobs
  has_many :shifts, through: :shift_jobs

  scope :active,          -> { where(active: true) }
  scope :inactive,        -> { where(active: false) }
  scope :alphabetical,    -> { order('name') }
  
end
