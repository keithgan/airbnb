Rails.application.routes.draw do
  get 'braintree/new'
  get 'welcome/index'
  root 'welcome#index'
  post 'braintree/checkout'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  resources :listings

  resources :listings do
    resource :reservation
  end

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users" do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/mylistings" => "listings#my_listings", as: "my_listings"
  get "/listings/:id/verify" => "listings#verify_listing", as: "verify_listing"
end
