class Flavor < ActiveRecord::Base
  has_many :store_flavors
  has_many :stores, through: :store_flavors

  scope :active,          -> { where(active: true) }
  scope :inactive,        -> { where(active: false) }
  scope :alphabetical,    -> { order('name') }

end
