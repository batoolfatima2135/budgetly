Rails.application.routes.draw do
  resources :categories
  get 'home/index'
  devise_for :users
  root 'home#index'
end
