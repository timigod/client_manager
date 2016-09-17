require_dependency "client_manager/application_controller"

module ClientManager
  class SessionsController < ApplicationController

    def login

    end


    def login_attempt
      authorized_user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
      if authorized_user
        flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.email}"
        redirect_to users_path
      else
        flash[:error] = "Invalid Username or Password"
        redirect_to login_path
      end
    end

  end
end
