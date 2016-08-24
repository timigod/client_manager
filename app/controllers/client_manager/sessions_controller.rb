require_dependency "client_manager/application_controller"

module ClientManager
  class SessionsController < ApplicationController

    def login

    end


    def login_attempt
      authorized_user = User.authenticate(params[:email], params[:login_password])
      if authorized_user
        flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.username}"
        redirect_to users_path
      else
        flash[:error] = "Invalid Username or Password"
        redirect_to login_path
      end
    end

  end
end
