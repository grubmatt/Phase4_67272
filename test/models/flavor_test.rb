require 'test_helper'

class FlavorTest < ActiveSupport::TestCase
  # Test relationships
  should have_many(:store_flavors)
  should have_many(:stores).through(:store_flavors)
  
  should validate_presence_of(:name)

  context "Creating a context for flavors" do
    # create the objects I want with factories
    setup do 
      create_flavors
    end
    
    # and provide a teardown method as well
    teardown do
      remove_flavors
    end

    should "Show that there is one active flavor" do
      assert_equal 1, Flavor.active.size
      assert_equal ["Chocolate"], Flavor.active.map{|i| i.name}.sort
    end

    should "Show that there is one inactive flavor" do
      assert_equal 1, Flavor.inactive.size
      assert_equal ["Vanilla"], Flavor.inactive.map{|i| i.name}.sort
    end

    should "List the flavors in alphabetical order" do
      assert_equal 2, Flavor.alphabetical.size
      assert_equal ["Chocolate", "Vanilla"], Flavor.alphabetical.map{|i| i.name}.sort
    end

    should "Show that flavors are never deleted, only made inactive" do
      @chocolate.destroy
      assert_equal 2, Flavor.inactive.size
      assert_equal ["Chocolate", "Vanilla"], Flavor.inactive.map{|i| i.name}.sort
    end
  end
end
