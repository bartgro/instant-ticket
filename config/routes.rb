Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :events, only: %I[index show] do
        resources :tickets, only: %I[index]
      end

      resource :orders, controller: 'orders', only: %i[] do
        get :draft
        post :create
        put :update
        post :check_out, path: 'check-out'
        post :pay
      end

      resources :shipping_types, only: %i[index], path: 'shipping-types'
      resources :tickets, only: %I[index show]
    end
  end
end
