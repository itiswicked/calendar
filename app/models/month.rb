class Month
  attr_reader :year, :month, :data
  def initialize(info_hash)
    @year = (info_hash[:year] || Time.now.year).to_i
    @month = (info_hash[:month] || Time.now.month).to_i
  end

  def create!
    @data = (1..num_of_days)
      .map { |day| create_day(@year, @month, day) }
      .unshift(prepend_month)
      .push(append_month)
      .flatten
  end

  def last_m
    jump_month(:-)
  end

  def next_m
    jump_month(:+)
  end

  def num_of_days
    Time.days_in_month(@month, @year)
  end

  def name
    time_obj.strftime("%B")
  end


  private

    def create_day(year, month, date)
      day = {}
      day[:date] = Time.new(year, month, date)
      day[:in_month] = in_month? day[:date]
      day[:today] = is_today? day[:date]
      day
    end

    def time_obj
      Time.new(@year,@month, 1)
    end

    def jump_month(operator)
      t = time_obj.send(operator, 1.month)
      Month.new(year: t.year, month: t.month)
    end

    def weekday_of_first
      time_obj.wday
    end

    def weekday_of_last
      Time.new(@year, @month, num_of_days).wday
    end

    def prepend_month
      (1..last_m.num_of_days)
        .to_a
        .last(weekday_of_first)
        .map { |n| create_day(last_m.year, last_m.month, n) }
    end

    def append_month
      (1..next_m.num_of_days)
        .to_a
        .first(6 - weekday_of_last)
        .map  { |n| create_day(next_m.year, next_m.month, n) }
    end

    def is_today?(date)
      Time.at(date).to_date === Time.at(Time.now).to_date
    end

    def in_month?(date)
      @month == date.month && @year == date.year
    end
end
