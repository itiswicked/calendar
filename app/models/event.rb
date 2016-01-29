  class Event < ActiveRecord::Base
  has_many :resources
  has_many :inventory_items, through: :resources

  validates :title, presence: true
  validates_datetime :start_time, before: :end_time,
                     before_message: 'Sorry, you can\'t create an event that ends before it starts.'
  validates_datetime :end_time, after: :start_time,
                     after_message: 'Sorry, you can\'t create an event that ends before it starts.'
  validates_date :start_time, is_at: :end_time,
                 is_at_message: "Sorry, event must start and finish on same day."
  validates_date :end_time, is_at: :start_time,
                 is_at_message: "Sorry, event must start and finish on same day."

  def self.find_by_date_range(start_date, end_date)
    where("start_time >= ? AND end_time < ?", start_date, end_date)
  end

  def self.find_by_date(date)
    where(start_time: date.beginning_of_day..date.end_of_day)
  end

  def to_partial_path
    'events/event'
  end

  def start_str
    start_time.strftime(display_time)
  end

  def end_str
    end_time.strftime(display_time)
  end

  def display_date
    start_time.strftime("%b %e, %Y")
  end

  def has_sound?
    has_category?("Sound")
  end

  def has_lighting?
    has_category?("Lighting")
  end

  def has_scenic?
    has_category?("Scenic")
  end

  def has_wardrobe?
    has_category?("Wardrobe")
  end

  def has_catering?
    has_category?("Catering")
  end

  private

  def display_time
    "%l:%M %p"
  end

  def has_category?(category)
    resources.select { |resource| resource.inventory_item.category == category }.any?
  end
end
