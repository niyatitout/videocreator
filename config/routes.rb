Rails.application.routes.draw do
  # Devise routes
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Root route (based on authentication)
  authenticated :user do
    root to: 'users#dashboard', as: :authenticated_root
  end
  root "home#index" # fallback root for unauthenticated users

  # User profile and dashboard
  resources :users, only: [:show, :edit, :update] do
    collection do
      get :dashboard
    end
  end

  # Video routes (RESTful)
  resources :videos, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # Channel Management (✅ now inside draw block!)
  resources :channels do
    member do
      patch :toggle_visibility
    end
  end
end
