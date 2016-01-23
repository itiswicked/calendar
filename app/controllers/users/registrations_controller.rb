class Users::RegistrationsController < Devise::RegistrationsController
  protected
    def after_sign_up_path_for
      months_path
    end

    def after_update_path_for(resource)
      signed_in_root_path(resource)
    end

    def after_sign_out_path
      '/'
    end
end
