class Event < ActiveRecord::Base
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
end
