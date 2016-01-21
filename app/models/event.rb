class Event < ActiveRecord::Base
  validates :title, presence: true

  def self.find_by_date_range(start_date, end_date)
    where("start_time >= ? AND end_time < ?", start_date, end_date)
  end

  def self.find_by_date(date)
    start_date = "#{date[:year]}-#{date[:month]}-#{date[:day]}"
    where("start_time = ?", start_date)
  end
end
