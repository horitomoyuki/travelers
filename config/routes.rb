Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"

  get '/users/search',  to: 'users#search'
  
  resources :users, only: [:index, :new, :edit, :update, :show] do
    collection do
      get 'search'
    end
  end
  resources :rooms, only: [:new, :create, :destroy] do
    resources :talks, only: [:index, :create]
  end
end
