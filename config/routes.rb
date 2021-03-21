Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"

  resources :users, only: [:index, :new, :edit, :update, :show]

  resources :rooms, only: [:new, :create, :destroy] do
    resources :messages, only: [:index, :create]
  end
end
