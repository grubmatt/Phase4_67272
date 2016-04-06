module Contexts
  module FlavorContexts
  	def create_flavors
      @vanilla = FactoryGirl.create(:flavor, name: "Vanilla", active: 0)
  	  @chocolate = FactoryGirl.create(:flavor)
  	end

  	def remove_flavors
  	  @chocolate.destroy
  	  @vanilla.destroy
  	end

  end
end