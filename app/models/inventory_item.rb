class InventoryItem < ActiveRecord::Base
  has_many :events, through: :resources

  validates :name, presence: true
  validates :category, presence: true

  def self.categories
    select(:category).map(&:category).uniq
  end
end
