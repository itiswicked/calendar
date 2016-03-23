class Month
  attr_reader :year, :month, :data
  def initialize(params)
    @year = (params[:year] || Time.now.year).to_i
    @month = (params[:month] || Time.now.month).to_i
  end

  def create!
    @data = (1..days_in_month)
      .map { |day| Day.new(@year, @month, day) }
      .unshift(prepend_month)
      .push(append_month)
      .flatten
  end

  def last_month
    jump_month(:-)
  end

  def next_month
    jump_month(:+)
  end

  def days_in_month
    Time.days_in_month(@month, @year)
  end

  def name
    time_obj.strftime("%B")
  end


  private

    def time_obj
      Time.new(@year, @month, 1)
    end

    def jump_month(operator)
      t = time_obj.send(operator, 1.month)
      Month.new(year: t.year, month: t.month)
    end

    def weekday_of_first
      time_obj.wday
    end

    def weekday_of_last
      Time.new(@year, @month, days_in_month).wday
    end

    def prepend_month
      (1..last_month.days_in_month)
        .to_a
        .last(weekday_of_first)
        .map { |n| Day.new(last_month.year, last_month.month, n) }
    end

    def append_month
      (1..next_month.days_in_month)
        .to_a
        .first(6 - weekday_of_last)
        .map { |n| Day.new(next_month.year, next_month.month, n) }
    end

    def is_today?(date)
      Time.at(date).to_date === Time.at(Time.now).to_date
    end

    def in_month?(date)
      @month == date.month && @year == date.year
    end
end
