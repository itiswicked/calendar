Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "callbacks",
    registrations: 'users/registrations'
  }

  devise_scope :user do
    root 'devise/sessions#new'
  end

  resources :events
  resources :months, only: [:index]
  resources :events do
    resources :resources, only: [:create, :edit, :update, :destroy]
  end
end
