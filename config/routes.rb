Rails.application.routes.draw do

  root to: "users#home"
  resources :users, only: [:update]

  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :api_keys, only: [:index, :new, :create, :destroy]
  resources :ops
end
