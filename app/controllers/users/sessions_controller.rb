class Users::SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(resource)
    # Redirect to dashboard after login
    dashboard_users_path
  end
end