class Month
  attr_reader :year, :month, :data

  def initialize(year, month)
    @year = (year || Time.now.year).to_i
    @month = (month || Time.now.month).to_i
  end

  def days
    @days ||= (1..days_in_month)
      .map { |day| Day.new(@year, @month, day) }
      .unshift(prepend_month)
      .push(append_month)
      .flatten
  end

  def weeks
    @weeks ||= days.each_slice(7).to_a
  end

  def last_month
    get_relative_month(:-)
  end

  def next_month
    get_relative_month(:+)
  end

  def days_in_month
    @days_in_month ||= Time.days_in_month(@month, @year)
  end

  def name
    time.strftime("%B")
  end

  def first_day
    days.first
  end

  def last_day
    days.last
  end


  private

    def time
      @time ||= Time.new(@year, @month, 1)
    end

    def get_relative_month(operator)
      target_month = time.send(operator, 1.month)
      Month.new(target_month.year, target_month.month)
    end

    def first_week_day
      time.wday
    end

    def last_week_day
      Time.new(@year, @month, days_in_month).wday
    end

    def prepend_month
      last_day = last_month.days_in_month
      ((last_day - first_week_day + 1)..last_day)
        .map { |n| Day.new(last_month.year, last_month.month, n) }
    end

    def append_month
      (1..(6 - last_week_day))
        .map { |n| Day.new(next_month.year, next_month.month, n) }
    end
end
