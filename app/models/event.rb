class Event < ActiveRecord::Base
  validates :title, presence: true

  def self.find_by_date_range(start_date, end_date)
    where(
      "start_time >= ? AND end_time < ?",
      start_date,
      end_date
    )
  end
end
