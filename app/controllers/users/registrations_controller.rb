class Users::RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for(resource)
      events_path
    end

    def after_update_path_for(resource)
      signed_in_root_path(resource)
    end

    def after_sign_out_path(resource)
      '/'
    end
end
