Sks::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :sessions
  match "/auth/google_oauth2/callback", to: "sessions#create"
  match "/logout", to: "sessions#destroy"

  root to: 'homes#index'
  match '/about', to: 'homes#about', as: :about

  match '/current_users/1', to: 'users#me'
  match '/users', to: 'users#index'

  match '/kudos', to: 'kudos#create'
  match '/comments', to: 'kudos#index'

  match '/tops', to: 'week#top_collectors'
  match '/hamsters', to: 'week#top_hamsters'

  match '/users/:id', to: 'users#show'
end
