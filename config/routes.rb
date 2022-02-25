require "sidekiq/web"
Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    mount Sidekiq::Web => "/sidekiq"
    root "homes#index"
    get "/contact", to: "homes#contact"
    get "/cart", to: "carts#index"
    post "/add_to_cart/:id", to: "carts#create", as: "add_to_cart"
    post "/select_option_cart", to: "carts#select_cart"
    post "/update_cart", to: "carts#update"
    delete "/remove_from_cart/:id", to: "carts#destroy", as: "remove_from_cart"
    get "/check_code", to: "discounts#show", as: "check_code"
    get "/history-order/:type", to: "orders#index", as: "history_orders"
    as :user do
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
      get "/signup", to: "devise/registrations#new"
    end
    devise_for :users
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index destroy)
    resources :products
    resources :homes, only: :index
    resources :comment_rates, only: %i(create destroy)
    resources :orders, except: %i(index destroy edit)

    namespace :admin do
      root "users#index"
      resources :users, only: %i(index update show)
      resources :categories
      resources :products
      resources :orders
      resources :revenue_managements, only: %i(index)

      get "/search-users", to: "users#search", as: "search_users"
    end
  end
end
