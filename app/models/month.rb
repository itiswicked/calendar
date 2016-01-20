class Month
  attr_reader :month, :year, :data
  def initialize(year, month)
    @month = month.to_i
    @year = year.to_i
  end

  def create!
    @data = (1..num_of_days)
      .to_a
      .map { |n| { date: Time.new(@year, @month, n), in_month: true } }
    prepend_month
    append_month
    @data.flatten!
    self
  end

  def last_month
    t = time_obj - 1.month
    Month.new(t.year, t.month)
  end

  def next_month
    t = time_obj + 1.month
    Month.new(t.year, t.month)
  end

  def num_of_days
    Time.days_in_month(@month, @year)
  end

  def name
    time_obj.strftime("%B")
  end

  private

    def weekday_of_first
      time_obj.wday
    end

    def weekday_of_last
      Time.new(@year, @month, num_of_days).wday
    end

    def time_obj
      Time.new(@year,@month, 1)
    end

    def prepend_month
      days = (1..last_month.num_of_days)
        .to_a
        .last(weekday_of_first)
        .map do |n|
          {
            date: Time.new(last_month.year, last_month.month, n),
            in_month: false
          }
        end
      @data.unshift(days)
    end

    def append_month
      days = (1..next_month.num_of_days)
        .to_a
        .first(6 - weekday_of_last)
        .map do |n|
          {
            date: Time.new(next_month.year, next_month.month, n),
            in_month: false
          }
        end
      @data << days
    end
end
