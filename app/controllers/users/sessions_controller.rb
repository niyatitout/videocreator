# app/controllers/users/sessions_controller.rb

module Users
  class SessionsController < Devise::SessionsController
    def create
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)

      if resource.otp_required_for_login?
        sign_out(resource)
        session[:otp_user_id] = resource.id
        render 'devise/sessions/two_factor'
      else
        respond_with resource, location: after_sign_in_path_for(resource)
      end
    end

    def after_sign_in_path_for(resource)
      dashboard_users_path
    end

    def verify_2fa
      user = User.find(session[:otp_user_id])
      if user.validate_and_consume_otp!(params[:otp_attempt])
        session.delete(:otp_user_id)
        sign_in(user)
        redirect_to after_sign_in_path_for(user)
      else
        flash.now[:alert] = "Invalid code"
        render 'devise/sessions/two_factor'
      end
    end
  end
end
