class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    render :index
  end

end
