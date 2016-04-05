class Flavor < ActiveRecord::Base
  has_many :store_flavors
  has_many :stores, through: :store_flavors

end
