module Contexts
  module FlavorContexts
  	def create_flavors
  	  @chocolate = FactoryGirl.create(:flavor)
  	  @vanilla = FactoryGirl.create(:flavor, name: "Vanilla", active: 0)
  	end

  	def remove_flavors
  	  @chocolate.destroy
  	  @vanilla.destroy
  	end

  end
end