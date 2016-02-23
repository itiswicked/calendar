class InventoryItem < ActiveRecord::Base
  has_many :events, through: :resources

  validates :name, presence: true
  validates :category, presence: true

  def self.categories_select
    selections = self.categories.map do |category|
      categorized_items = all
        .select { |item| item.category == category }
        .map { |item| [item.name, item.id] }
      [category, categorized_items]
    end
    Hash[selections]
  end

  def self.categories
    select(:category).map(&:category).uniq
  end
end
