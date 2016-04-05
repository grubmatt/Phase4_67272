class StoreFlavor < ActiveRecord::Base
  belongs_to :flavor
  belongs_to :store
end
