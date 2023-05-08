Rails.application.routes.draw do
  get '/', to: redirect('/users/sign_in')

  resources :inventories do
    get 'new_movement', on: :member
    post 'create_movement', on: :member
  end

  resources :movements
  resources :products
  resources :clients
  resources :providers
  resources :categories
  resources :dashboard, only: [:index]
  resources :account, only: %i[index update]

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'logout', to: 'pages#logout', as: 'logout'

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
