module Contexts
  module ShiftContexts

    #NEEDS TO BE ADDED TO TO PROPERLY TEST ALL FUNCTIONS
  	def create_shifts
  	  @current_shift = FactoryGirl.create(:shift)
  	  @future_shift = FactoryGirl.create(:shift, date: Date.current + 5, start_time: "9:00:00")
  	end

  	def remove_shifts
  	  @current_shift.destroy
  	  @future_shift.destroy
  	end

  end
end
