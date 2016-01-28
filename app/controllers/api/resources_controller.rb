class Api::ResourcesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    render nothing: true, status: 200, content_type: "text/html"
  end
end
