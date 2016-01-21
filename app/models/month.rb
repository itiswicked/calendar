class Month
  attr_reader :month, :year, :data
  def initialize(info_hash)
    @month = (info_hash[:month] || Time.now.month).to_i
    @year = (info_hash[:year] || Time.now.year).to_i
  end

  def create!
    @data = (1..num_of_days)
      .map { |n| { date: Time.new(@year, @month, n), in_month: true } }
      .map { |day| today?(day) }
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

  def today?(day)
    if Time.at(day[:date]).to_date === Time.at(Time.now).to_date
      day[:today] = true
    else
      day[:today] = false
    end
    day
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

    def jump_month(operator)
      t = time_obj.send(operator, 1.month)
      Month.new(year: t.year, month: t.month)
    end

    def prepend_month
      (1..last_m.num_of_days)
        .to_a
        .last(weekday_of_first)
        .map do |n|
          {
            date: Time.new(last_m.year, last_m.month, n),
            in_month: false
          }
        end
    end

    def append_month
      (1..next_m.num_of_days)
        .to_a
        .first(6 - weekday_of_last)
        .map do |n|
          { date: Time.new(next_m.year, next_m.month, n), in_month: false }
        end
    end
end
