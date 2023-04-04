Rails.application.routes.draw do
  root 'pages#home'
  resources :products
  resources :providers
  resources :categories

  devise_for :users
  get 'logout', to: 'pages#logout', as: 'logout'

  resources :dashboard, only: [:index]
  resources :account, only: %i[index update]

  # static pages
  pages = %w[
    privacy terms
  ]

  pages.each do |page|
    get "/#{page}", to: "pages##{page}", as: "#{page.gsub('-', '_')}"
  end

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
