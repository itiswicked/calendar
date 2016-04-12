class Api::EventsController < ApplicationController
  before_action :authenticate_user!

  def show
    @event = Event.find(params[:id])
    @options = InventoryItem.categories_select
    @resources = Resource.and_inventory_info(@event.id)

    binding.pry
    if @event
      render json: resources_with_dropdown_opts, status: 200
    else
      render :nothing, status: 404
    end
  end

  private

  def resources_in(category)
    @resources.select do |resource|
      resource[:category] == category.to_s.capitalize
    end
  end

  def resources_with_dropdown_opts
    {
      sound: { resources: resources_in(:sound), options: @options[:sound] },
      lighting: { resources: resources_in(:lighting), options: @options[:lighting] },
      scenic: { resources: resources_in(:scenic), options: @options[:scenic] },
      wardrobe: { resources: resources_in(:wardrobe), options: @options[:wardrobe] },
      catering: { resources: resources_in(:catering), options: @options[:catering] }
    }
  end
end
