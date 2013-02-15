Sks::Application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :homes, only:[:index]
  root to: 'homes#index'
end
