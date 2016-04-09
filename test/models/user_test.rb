require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to(:employee)

  

  context "Creating a context for Users" do
  	# create the objects I want with factories
    setup do 
      create_users
    end
    
    # and provide a teardown method as well
    teardown do
      remove_users
    end

  end
end
