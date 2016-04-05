module Contexts
  module ShiftContexts

    #NEEDS TO BE ADDED TO TO PROPERLY TEST ALL FUNCTIONS
  	def create_shifts
  	  @past_shift = FactoryGirl.create(:shift)
  	  @current_shift = FactoryGirl.create(:shift, date: Date.today, start_time: "9:00:00", end_time: nil)
  	  @future_shift = FactoryGirl.create(:shift, date: Date.today + 5, start_time: "9:00:00")
  	end

  	def remove_shifts
  	  @past_shift.destroy
  	  @current_shift.destroy
  	  @future_shift.destroy
  	end

  end
end
