class TwoFactorAuthsController < ApplicationController
  before_action :authenticate_user! # Ensure user is logged in

  def new
    # Generate a secret for QR code
    @otp_secret = ROTP::Base32.random
    totp = ROTP::TOTP.new(@otp_secret, issuer: "Your App Name")
    @provisioning_uri = totp.provisioning_uri(current_user.email)
  end

  def create
    # Verify the code user entered
    totp = ROTP::TOTP.new(current_user.otp_secret, issuer: "Your App Name")
    
    if totp.verify(params[:code], drift_behind: 15)
      current_user.update!(otp_required_for_login: true)
      redirect_to root_path, notice: "2FA enabled successfully!"
    else
      redirect_to new_two_factor_auth_path, alert: "Invalid code, please try again"
    end
  end

  def destroy
    current_user.update!(
      otp_required_for_login: false,
      otp_secret: nil
    )
    redirect_to root_path, notice: "2FA has been disabled"
  end
end