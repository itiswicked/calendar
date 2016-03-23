class MonthsController < ApplicationController
  before_action :authenticate_user!

  def index
    @month = Month.new(month_params)
    @month.create!
    first_date = @month.data.first.date.to_s
    last_date = @month.data.last.date.to_s
    @events = Event.find_by_date_range(first_date, last_date)
  end

  private

  def date_has_event?(date, events)
    events.select { |event| event.start_time.day == date.day }.any?
  end

  def month_params
    params.permit(:year, :month)
  end
end
