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

  def edit
binding.pry
    @resource = Resource.find(params[:id])
    @event = @resource.event
    @categories_select = InventoryItem.categories_select
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(resource_params)
      redirect_to @resource.event
    else
      flash[:alert] = @resource.errors.full_messages.join(", ")
      @event = @resource.event
      @categories_select = InventoryItem.categories_select
      render :edit
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to @resource.event
  end

  private

  def resource_params
    params.require(:resource).permit(:event_id, :inventory_item_id, :quantity)
  end
end
