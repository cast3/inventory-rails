Rails.application.routes.draw do
  root to: 'dashboard#index'

  resources :categories
  resources :products do
    get 'new_movement', on: :member
    post 'create_movement', on: :member
  end

  resources :providers

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  get 'logout', to: 'pages#logout', as: 'logout'

  resources :dashboard, only: [:index]
  resources :account, only: %i[index update]


  # admin panels
  authenticated :user, ->(user) { user.admin? } do
    namespace :admin do
      resources :dashboard, only: [:index]
      resources :impersonations, only: [:new]
      resources :users, only: %i[index show edit update destroy new create]
    end

    # convenience helper
    get 'admin', to: 'admin/dashboard#index'
  end
end
