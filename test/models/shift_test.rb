require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  should have_many(:shift_jobs)
  should have_many(:jobs).through(:shift_jobs)
  should belong_to(:assignment)
  should have_one(:store).through(:assignment)
  should have_one(:employee).through(:assignment)

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
      @bad_shift.end_time = @bad_shift.start_time - 1.hours
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
      @past_shift = FactoryGirl.create(:shift)
      @past_shift.update_attribute(:date, Date.current-5)
      @past_shift.destroy
      assert !@past_shift.destroyed?
      @future_shift.destroy
      assert @future_shift.destroyed?
    end

    should "Check if completed? works" do
      @past_shift = FactoryGirl.create(:shift)
      @past_shift.update_attribute(:date, Date.current-5)
      assert !@past_shift.completed?

      @past_shift.destroy
    end

    should "Check if end_time automatically set" do
      @another_shift = FactoryGirl.create(:shift, start_time: Date.current + 2.hours)
      assert @another_shift.end_time == Date.current + 5.hours
      @another_shift.destroy
    end

    should "Check if start_now works" do
      @another_shift = FactoryGirl.create(:shift, start_time: Date.current + 2.hours)
      @another_shift.start_now
      assert_in_delta 1, Time.now.to_i, @another_shift.start_time.to_i
      @another_shift.destroy
    end

    should "Check if end_now works" do
      @another_shift = FactoryGirl.create(:shift, start_time: Date.current + 2.hours)
      @another_shift.end_now
      assert_in_delta 1, Time.now.to_i, @another_shift.end_time.to_i
      @another_shift.destroy
    end

    should "have a scope completed that works" do
      @past_shift = FactoryGirl.create(:shift)
      @past_shift.update_attribute(:date, Date.current-5)
      @job_cash = FactoryGirl.create(:job)
      @shift_job_cash = FactoryGirl.create(:shift_job, shift_id: 3, job_id: 1)

      assert_equal [3], Shift.completed.map{|i| i.id}
      @past_shift.destroy
      @job_cash.destroy
      @shift_job_cash.destroy
    end

    should "have a scope incompleted that works" do
      assert_equal [1,2], Shift.incompleted.map{|i| i.id}.sort
    end

    should "have a scope for_store that works" do
      assert_equal [1,2], Shift.for_store(1).map{|i| i.id}.sort
    end

    should "have a scope for_employee that works" do
      assert_equal [1,2], Shift.for_employee(1).map{|i| i.id}.sort
    end

    should "have a scope past that works" do
      @past_shift = FactoryGirl.create(:shift)
      @past_shift.update_attribute(:date, Date.current-5)

      assert_equal [3], Shift.past.map{|i| i.id}
      @past_shift.destroy
    end

    should "have a scope upcoming that works" do
      assert_equal [1,2], Shift.upcoming.map{|i| i.id}.sort
    end

    should "have a scope for_next_days that works" do
      assert_equal [1], Shift.for_next_days(3).map{|i| i.id}.sort
      assert_equal [1,2], Shift.for_next_days(6).map{|i| i.id}.sort
    end

    should "have a scope for_past_days that works" do
      @past_shift = FactoryGirl.create(:shift)
      @past_shift.update_attribute(:date, Date.current-5)

      assert_equal [3], Shift.for_past_days(6).map{|i| i.id}.sort
      @past_shift.destroy
    end

    should "have a scope chronological that works" do
      @past_shift = FactoryGirl.create(:shift)
      @past_shift.update_attribute(:date, Date.current-5)

      assert_equal [3, 1, 2], Shift.chronological.map{|i| i.id}
      @past_shift.destroy
    end

    should "have a scope by_store that works" do
      @akland = FactoryGirl.create(:store, name: "Akland", phone: "412-268-8211")
      @cindy = FactoryGirl.create(:employee, first_name: "Cindy", last_name: "Crawford", ssn: "084-35-9822", date_of_birth: 17.years.ago.to_date)
      @another_assign = FactoryGirl.create(:assignment, store: @akland, employee: @cindy, start_date: 4.months.ago.to_date, end_date: nil)
      @past_shift = FactoryGirl.create(:shift, assignment_id: 2)
      @past_shift.update_attribute(:date, Date.current-5)

      assert_equal [3,1,2], Shift.by_store.map{|i| i.id}
      @past_shift.destroy      
      @another_assign.destroy
      @akland.destroy
      @cindy.destroy
    end

    should "have a scope by_employee that works" do
      @akland = FactoryGirl.create(:store, name: "Akland", phone: "412-268-8211")
      @cindy = FactoryGirl.create(:employee, first_name: "Cindy", last_name: "Crawford", ssn: "084-35-9822", date_of_birth: 17.years.ago.to_date)
      @another_assign = FactoryGirl.create(:assignment, store: @akland, employee: @cindy, start_date: 4.months.ago.to_date, end_date: nil)
      @past_shift = FactoryGirl.create(:shift, assignment_id: 2)
      @past_shift.update_attribute(:date, Date.current-5)

      assert_equal [3,1,2], Shift.by_employee.map{|i| i.id}
      @past_shift.destroy      
      @another_assign.destroy
      @akland.destroy
      @cindy.destroy
    end
  end
end
