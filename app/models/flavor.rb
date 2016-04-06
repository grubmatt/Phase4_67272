class Flavor < ActiveRecord::Base
  has_many :store_flavors
  has_many :stores, through: :store_flavors

  validates_presence_of :name

  scope :active,          -> { where(active: true) }
  scope :inactive,        -> { where(active: false) }
  scope :alphabetical,    -> { order('name') }

  before_destroy :cancel_destroy
  after_rollback :make_inactive

  private
  def cancel_destroy
  	return false
  end
  def make_inactive
  	self.active = 0
  	self.save
  end
end
