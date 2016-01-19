class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
    def after_sign_in_path_for(resource)
      events_path
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
    end
end
