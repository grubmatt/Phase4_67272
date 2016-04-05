class ShiftJob < ActiveRecord::Base
  belongs_to :shift 
  belongs_to :job
end
