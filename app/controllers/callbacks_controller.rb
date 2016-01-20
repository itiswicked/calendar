class CallbacksController < Devise::OmniauthCallbacksController
    def github
      @user = User.find_or_create_from_omniauth(request.env["omniauth.auth"])
      sign_in @user
      redirect_to months_path
    end
end
