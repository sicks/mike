Rails.application.routes.draw do

  root to: "ops#index"
  resources :users, only: [:update]

  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :api_keys, only: [:index, :new, :create, :destroy]
  resources :ops do
    get :conclude
    resources :claims, only: [:new, :create, :edit, :update, :destroy]
    resources :participants, only: [:create, :update, :destroy]
  end
  resources :claimables
  resources :payouts, only: [:index, :create]
  post '/payouts/new', to: 'payouts#new', as: 'new_payout'
end
