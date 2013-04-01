Sks::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :sessions
  match "/auth/google_oauth2/callback", to: "sessions#create"

  root to: 'homes#index'
  match '/about', to: 'homes#about', as: :about
end
