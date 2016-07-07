Rails.application.routes.draw do


  root to: "home#index"

  match "/webhook", to: "bot#webhook", defaults: {format: :json}, via: [:get, :post]
end
