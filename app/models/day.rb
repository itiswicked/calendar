class Day
  attr_reader :date, :month, :year

  def initialize(year, month, date)
    @year = year
    @month = month
    @date = date


    @time_object = Time.new(year, month, date)
  end

  def to_s
    @time_object.strftime("%Y-%m-%d")
  end

  def in_month?(month)
    month = Time.new(month.year, month.month)
    @month == month.month && @year == month.year
  end

  def today?
    Time.at(@time_object).to_date === Time.at(Time.now).to_date
  end

  def has_events?
    !Event.find_by_date(self).empty?
  end

  def beginning_of_day
    @time_object
  end

  def end_of_day
    @time_object + 1.day - 1.second
  end
end
