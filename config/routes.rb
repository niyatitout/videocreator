Rails.application.routes.draw do
  # ActiveAdmin + Devise (Admin)
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise for regular users with custom controllers
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }




  # Root paths
  authenticated :user do
    root to: 'users#dashboard', as: :authenticated_root
  end
  root 'home#index' # For unauthenticated users

  # Users - show/edit/update/dashboard
  resources :users, only: [:show, :edit, :update] do
    collection do
      get :dashboard
      get :security_settings  # ✅ Move it here under users
    end
  end

  # Videos
  resources :videos, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  # Channels
  resources :channels do
    member do
      patch :toggle_visibility
    end
  end

  # Two-Factor Auth settings (nested under `users` module)
  namespace :users do
    authenticate :user do
      resource :two_factor_settings, only: [:show, :create, :destroy], path: 'settings/two_factor'
      resource :two_factor_recovery_codes, only: [:show, :create], path: 'settings/two_factor/recovery_codes'
    end
  end

  # 2FA OTP verification and fallback routes
  post '/verify_2fa', to: 'sessions#verify_otp'

  # 2FA enable/disable routes (standalone resource)
  resources :two_factor_auths, only: [:new, :create, :destroy]
end
