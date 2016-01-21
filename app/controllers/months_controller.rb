class MonthsController < ApplicationController
  before_action :authenticate_user!

  def index
    @month = Month.new(month_params)
    @month.create!
    first_date = @month.data.first[:date].strftime("%Y-%m-%d")
    last_date = @month.data.last[:date].strftime("%Y-%m-%d")
    @events = Event.find_by_date_range(first_date, last_date)
    @month.data.each do |date|
      date_has_event?(date[:date], @events) ? date[:event] = true : date[:event] = false
    end
  end

  private

  def date_has_event?(date, events)
    events.select { |event| event.start_time.day == date.day }.any?
  end


  def month_params
    params.permit(:year, :month)
    # { year: params[:year], month: params[:month] }
  end
end
