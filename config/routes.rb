Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "homes#index"

    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/cart", to: "carts#checkout"
    get "/contact", to: "homes#contact"

    resources :users
    resources :products
  end
end
