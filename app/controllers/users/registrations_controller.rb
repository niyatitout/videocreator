class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    # Redirect to profile setup after signup
    edit_user_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    # Redirect after email confirmation (if using confirmable)
    edit_user_path(resource)
  end
end