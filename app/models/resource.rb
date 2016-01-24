class Resource < ActiveRecord::Base
  belongs_to :event
  belongs_to :inventory_item

  validates :quantity, presence: true
  validates :inventory_item_id, presence: true
  validates :event_id, presence: true
end
