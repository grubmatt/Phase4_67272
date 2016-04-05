class Shift < ActiveRecord::Base
  has_many :shift_jobs
  has_many :jobs, through: :shift_jobs
  belongs_to :assignment
end
