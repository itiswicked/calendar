class CallbacksController < Devise::OmniauthCallbacksController
    def github
      @user = User.find_or_create_from_omniauth(request.env["omniauth.auth"])
binding.pry
      sign_in @user
      redirect_to events_path
    end
end
