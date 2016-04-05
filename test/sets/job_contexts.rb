module Contexts
  module JobContexts
  	def create_jobs
 	  @cashier = FactoryGirl.create(:job)
 	  @mopper = FactoryGirl.create(:job, name: "Mopper", description: "Cleaned the floor", active: 0)
  	end

  	def remove_jobs
  	  @cashier.destroy
  	  @mopper.destroy
  	end
  end
end