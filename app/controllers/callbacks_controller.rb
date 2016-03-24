class CallbacksController < Devise::OmniauthCallbacksController
    def github
      @user = User.find_or_create_from_omniauth(request.env["omniauth.auth"])
      sign_in_and_redirect @user
    end
end
