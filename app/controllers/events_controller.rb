class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    binding.pry
  end

  private

  def date_params
    params.permit(:day, :month, :year)
  end
end
