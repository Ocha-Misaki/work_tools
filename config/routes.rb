Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :users do
    root 'homes#index'
    resources :groups do
      resource :invitation, only: :create
      resources :tasks, only: %i[index show]
    end
    resource :summary, only: %i[create]
    resources :tasks
    resources :daily_reports
    resources :reflections
  end
end
