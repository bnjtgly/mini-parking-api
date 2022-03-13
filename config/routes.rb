Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Admin
  namespace :admin_api do
    namespace :v1 do
      resources :users, param: :user_id, only: %i[index show update create destroy]
      resources :customers, param: :customer_id, only: %i[index show update create destroy]
      resources :customer_parkings, only: %i[index create]
      resources :parking_complex, param: :parking_complex_id, only: %i[index show update create destroy]
      resources :parking_slots, param: :parking_slot_id, only: %i[index show create]
      resources :entities, only: [:index]
      resources :sub_entities, only: [:index]
      resources :invoices, param: :invoice_id, only: %i[index]
      resources :dashboard, only: [:index]

      post 'customer_parkings/checkout', to: 'customer_parkings#checkout'
    end
  end

  # Clients
  namespace :api do
    namespace :v1 do
      resources :users, param: :user_id, only: %i[index]
      resources :entities, only: [:index]
      resources :sub_entities, only: [:index]
      resources :customer_parkings, only: %i[index create]
      resources :parking_complex, param: :parking_complex_id, only: %i[index]
      resources :parking_slots, param: :parking_slot_id, only: %i[index]
      resources :customers, param: :customer_id, only: %i[index]
      resources :invoices, param: :invoice_id, only: %i[index]

      post 'customer_parkings/update_parking', to: 'customer_parkings#update_parking'
    end
  end

  post 'authentication', to: 'authentication#authentication'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'sign_up'
  }, controllers: { sessions: 'sessions', registrations: 'registrations' }

end
