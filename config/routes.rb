Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/sign_up", to: "users#new", as: :new_user_registration
  post "/users", to: "users#create"

  get "/dashboard", to: "dashboard#show", as: :dashboard

  get "/sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create", as: :session
  delete "/logout", to: "sessions#destroy", as: :logout
end
