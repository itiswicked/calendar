class Resource < ActiveRecord::Base
  belongs_to :event
  belongs_to :inventory_item  
end
