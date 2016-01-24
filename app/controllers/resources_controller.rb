class ResourcesController < ApplicationController
  before_action :authenticate_user!

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to @resource.event
    else
      flash[:alert] = @resource.errors.full_messages.join(", ")
      @event = @resource.event
      @categories = InventoryItem.categories
      @categories_select = InventoryItem.categories_select
      @resources = @resource.event.resources
      render template: 'events/show'
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:event_id, :inventory_item_id, :quantity)
  end
end
