Rails.application.routes.draw do
  get "videos/index"
  get "videos/new"
  get "videos/create"
  get "videos/show"
  get "videos/edit"
  get "videos/update"
  get "videos/destroy"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # User profile routes
  resources :users, only: [:show, :edit, :update] do
    collection do
      get :dashboard
    end
  end

  # Add this line to create video resources
  resources :videos, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # Set root path based on authentication status
  authenticated :user do
    root to: 'users#dashboard', as: :authenticated_root
  end
  root "home#index"
end