class Api::EventsController < ApplicationController
  before_action :authenticate_user!

  def show
    @event = Event.find(params[:id])
    @options = InventoryItem.categories_select
    render json: resources_with_dropdown_opts, status: 200
  end

  private

  def resources_in(category)
    @resources ||= Resource.and_inventory_info(@event.id)
    @resources.select do |resource|
      resource["category"] == category.to_s.capitalize
    end
  end

  def resources_with_dropdown_opts
    {
      sound: { resources: resources_in(:sound), options: @options['Sound'] },
      lighting: { resources: resources_in(:lighting), options: @options['Lighting'] },
      scenic: { resources: resources_in(:scenic), options: @options['Scenic'] },
      wardrobe: { resources: resources_in(:wardrobe), options: @options['Wardrobe'] },
      catering: { resources: resources_in(:catering), options: @options['Catering'] }
    }
  end
end
