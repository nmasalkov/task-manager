Rails.application.routes.draw do
  devise_for :users
  root 'dashboards#index'
  resources :dashboards, only: [:index]
  resources :tasks
end
