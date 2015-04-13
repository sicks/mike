Rails.application.routes.draw do

  root to: "users#home"

  get '/login', to: 'sessions#new'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :api_keys
end
