Rails.application.routes.draw do
  resources :payments
  resources :categories
  get 'home/index'
  devise_for :users
  root 'home#index'
end
