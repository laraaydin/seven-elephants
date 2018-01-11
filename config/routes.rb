Rails.application.routes.draw do
  namespace :admin do
    resources :orders do
      post :ship
      post :cancel
    end
    resources :products
    resources :order_products

    root to: "orders#index"
  end

  root "products#index"

  get :cart, to: "orders#current"
  get :shipping_method, to: "orders#shipping_rates_index"
  post :update_shipping_method, to: "orders#update_shipping_method"
  get :checkout, to: "orders#checkout"
  get :shipping_info, to: "shipping_infos#new", as: :new_shipping_info
  post :shipping_info, to: "shipping_infos#create", as: :shipping_info

  resources :order_products, only: %i[create update destroy]
  resources :products, only: %i[index show]
  resources :charges
end
