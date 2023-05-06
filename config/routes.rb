Rails.application.routes.draw do
  get '/', to: redirect('/users/sign_in')

  # get 'movement/registrar_movimiento'
  # get 'movement/mostrar_movimientos'
  # get 'inventory/agregar_producto'
  # get 'inventory/quitar_producto'
  # get 'inventory/mostrar_inventario'

  resources :inventories

  resources :movements

  resources :products do
    member do
      get :new_movement
      post :create_movement
    end
  end

  resources :clients

  resources :providers

  resources :categories

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'logout', to: 'pages#logout', as: 'logout'

  resources :dashboard, only: [:index]

  resources :account, only: %i[index update]

  # admin panels
  authenticated :user, ->(user) { user.role == 'admin' } do
    namespace :admin do
      resources :dashboard, only: [:index]
      resources :impersonations, only: [:new]
      resources :users, only: %i[index show edit update destroy new create]
    end

    # convenience helper
    get 'admin', to: 'admin/dashboard#index'
  end
end
