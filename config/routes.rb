Rails.application.routes.draw do


  devise_for :users
  resources :conversations
  root to: "home#index"

  match "/webhook", to: "bot#webhook", via: [:get, :post]
end
