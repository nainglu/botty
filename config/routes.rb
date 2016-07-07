Rails.application.routes.draw do


  root to: "home#index"

  match "/webhook", to: "bot#webhook", via: [:get, :post]
end
