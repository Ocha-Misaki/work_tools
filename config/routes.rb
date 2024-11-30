Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :users do
    root 'homes#index'
    resources :groups do
      resource :invitation, only: :create
    end
  end
end
