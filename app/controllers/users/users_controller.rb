module Users
  class UsersController < ApplicationController
    def security_settings
      @user = current_user
    end
  end
end
