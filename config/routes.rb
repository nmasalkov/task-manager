Rails.application.routes.draw do

  devise_for :users
  root 'dashboard#index'
  resources :dashboard, only: [:index]
end
