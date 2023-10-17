Rails.application.routes.draw do
  resources :categories,  only: [:new, :create, :index] do
    resources :payments, only: [:index, :new, :create]
  end
  get 'home/index'
  devise_for :users
  root 'home#index'
end
