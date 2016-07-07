Rails.application.routes.draw do


  resources :conversations
  root to: "home#index"

  match "/webhook", to: "bot#webhook", via: [:get, :post]
end
