Rails.application.routes.draw do
  resources :products
  resources :providers
  resources :categories
  root 'pages#home'

  devise_for :users
  get 'logout', to: 'pages#logout', as: 'logout'

  resources :dashboard, only: [:index]
  resources :account, only: [:index, :update]

  # static pages
  pages = %w(
    privacy terms
  )

  pages.each do |page|
    get "/#{page}", to: "pages##{page}", as: "#{page.gsub('-', '_')}"
  end

  # admin panels
  authenticated :user, -> user { user.admin? } do
    namespace :admin do
      resources :dashboard, only: [:index]
      resources :impersonations, only: [:new]
      resources :users, only: [:edit, :update, :destroy]
    end

    # convenience helper
    get 'admin', to: 'admin/dashboard#index'
  end
end
