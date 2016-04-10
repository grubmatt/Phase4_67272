class User < ActiveRecord::Base
  belongs_to :employee

  has_secure_password

  # Validations
  validates_uniqueness_of :email, :employee_id
  validates_presence_of :password_digest, on: :create
  validate :employee_is_active_in_system, on: :create
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"

  private
  def employee_is_active_in_system
    all_active_employees = Employee.active.map(&:id)
    unless all_active_employees.include?(self.employee_id)
      errors.add(:employee_id, "is not an active employee at the creamery")
    end
  end
end
