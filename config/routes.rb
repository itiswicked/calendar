Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }

  devise_scope :user do
    root 'devise/sessions#new'
  end

  resources :events, only: [:index]
end
