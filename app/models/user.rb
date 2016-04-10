class User < ActiveRecord::Base
  belongs_to :employee

  # Validations
  validate_uniqueness_of :email
  validate :employee_is_active_in_system, on: :create
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  private
  def employee_is_active_in_system
    all_active_employees = Employee.active.all.map{|e| e.id}
    unless all_active_employees.include?(self.employee_id)
      errors.add(:employee_id, "is not an active employee at the creamery")
    end
  end
end
