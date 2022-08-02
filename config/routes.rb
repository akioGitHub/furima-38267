Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to: 'items#index'
  resources :users, only: [:show, :update]
  resources :items do
    resources :orders, only: [:index, :create]
  end
end
