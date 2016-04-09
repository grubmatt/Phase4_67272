require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  should have_many(:shift_jobs)
  should have_many(:jobs).through(:shift_jobs)
  should belong_to(:assignment)

  should validate_presence_of(:date)
  should validate_presence_of(:start_time)
  should validate_presence_of(:assignment_id)

  context "Creating context for shift" do
  	setup do
  	  @ed = FactoryGirl.create(:employee)
  	  @cmu = FactoryGirl.create(:store)
  	  @generic_assign = FactoryGirl.create(:assignment, store: @cmu, employee: @ed, start_date: 3.months.ago.to_date, end_date: nil)
      create_shifts
    end
    teardown do
      @ed.destroy
      @cmu.destroy
      @generic_assign.destroy
      remove_shifts
    end

    should "Assure that an end_time cant be before the start_time" do
      @bad_shift = FactoryGirl.build(:shift)
      @bad_shift.end_time = "9:00:00"
      assert !@bad_shift.valid?
    end

    should "Assure that date is not in the past for a new shift" do
      @bad_shift = FactoryGirl.build(:shift, date: Date.current - 2)
      assert !@bad_shift.valid?
    end

    should "Assure that shift cannot be added to an inactive assignment" do
      @bad_shift = FactoryGirl.build(:shift, assignment_id: 4)
      assert !@bad_shift.valid?
    end

    should "Assure that a past shift cant be deleted" do
      @past_shift = FactoryGirl.build(:shift, end_time: "14:00:00")
      @past_shift.update_attribute(:date, Date.current-5)
      @past_shift.destroy
      assert !@past_shift.destroyed?
      @future_shift.destroy
      assert @future_shift.destroyed?
    end

    should "Check if a shift is completed" do

    end
  end
end
