class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @date = date
    @yesterday = yesterday
    @tomorrow = tomorrow
    @event = Event.new
    @events = Event.find_by_date(@date).order(:start_time)
    @button_text = "Add Event"
  end

  def new
    @event = Event.new
    @button_text = "Add"
  end

  def show
    @event = Event.find(params[:id])
    @categories = InventoryItem.categories
    @categories_select = InventoryItem.categories_select
    @resource = Resource.new
    @resources = @event.resources
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to event_path @event
    else
      @date = date(params[:event][:date])
      @events = Event.find_by_date(@date)
      flash[:alert] = @event.errors.full_messages.uniq.join(", ")
      render :index
    end
  end

  def edit
    @event = Event.find(params[:id])
    @button_text = "Update"
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      redirect_to event_path @event
    else
      flash[:alert] = @event.errors.full_messages.uniq.join(", ")
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @date = @event.start_time
    @event.destroy

    @event = Event.new
    @events = Event.find_by_date @date
    render :index
  end

  private

  def date(date_arg = nil)
    return Date.parse(date_arg) if date_arg
    Date.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")
  end

  def yesterday
    {
      day: (date - 1.day).day,
      month: (date - 1.day).month,
      year:  (date - 1.day).year
    }
  end

  def tomorrow
    {
      day: (date + 1.day).day,
      month: (date + 1.day).month,
      year:  (date + 1.day).year
    }
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time)
  end
end
