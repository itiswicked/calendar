class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = Event.where(start_time: date.beginning_of_day..date.end_of_day)
    @date = date.strftime("%A %b %-d, %Y")
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def date
    Date.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")
  end
end
