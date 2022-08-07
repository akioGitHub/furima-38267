Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  devise_for :users
  root to: 'items#index'
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
  resources :items do
    collection do
      get 'search'
    end
    collection do
      get 'item_search'
    end
    resources :orders, only: [:index, :create]
  end
end
