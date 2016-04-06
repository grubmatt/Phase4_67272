module Contexts
  module JobContexts
  	def create_jobs
 	  @mopper = FactoryGirl.create(:job, name: "Mopper", description: "Cleaned the floor", active: 0)
 	  @cashier = FactoryGirl.create(:job)
  	end

  	def remove_jobs
  	  @mopper.destroy
  	  @cashier.destroy
  	end
  end
end