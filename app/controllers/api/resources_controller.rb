class Api::ResourcesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end

  def update
binding.pry
    @resource = Resource.find(params[:id])
    if @resource.update_attributes(resource_params)
      render json: @resource
    else
      render nothing: true, status: 500, content_type: "text/html"
    end
  end

  private

  def resource_params
    params.require(:resource).permit(:quantity)
  end
end
