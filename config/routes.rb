Rails.application.routes.draw do
  root 'events#index'

  devise_for :users, controllers: { omniauth_callbacks: "callbacks" }
  devise_scope :user { root 'devise/sessions#new' }

  resources :events, only: [:index]
end
