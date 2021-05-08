Rails.application.routes.draw do
  devise_for :users

  root to: 'users#index'

  get '/users/search', to: 'users#search'
  get '/users/search_index', to: 'users#search_index'
  get '/rooms/index', to: 'rooms#index'
  
  devise_scope :user do
    post '/users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:index, :new, :edit, :update, :show] do
    collection do
      get 'search'
    end
    resources :favorites, only: [:create, :destroy]
    # resources :footprints, only: [:index, :create]
    # member do
    #   get :show
    #   get :follower
    #   get :following
    # end
    resources :relationships, only: [:create, :destroy]
  end

  resources :rooms, only: [:new, :create, :destroy] do
    resources :talks, only: [:index, :create]
  end
end
