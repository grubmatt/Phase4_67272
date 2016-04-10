require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should belong_to(:employee)

  # Validating email (taken from PATS)
  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)

  context "Creating a context for Users" do
  	# create the objects I want with factories
    setup do 
      @ed = FactoryGirl.create(:employee)
      @gruberman = FactoryGirl.create(:user)
    end
    
    # and provide a teardown method as well
    teardown do
      @ed.destroy
      @gruberman.destroy
    end

    should "Assure that user can only be added to an active employee" do
      assert @gruberman.valid?
      @bad_user = FactoryGirl.build(:user, employee_id: 12)
      assert !@bad_user.valid?
    end

    should "Show that user is automatically deleted when employee is deleted" do
      @ed.destroy
      assert @ed.destroyed?
      assert @gruberman.destroyed?
    end

  end
end
