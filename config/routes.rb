Rails.application.routes.draw do
  get 'cards/new'
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root to: 'items#index'
  resources :users, only: [:show, :update, :new]
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
