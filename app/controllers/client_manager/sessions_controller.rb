require_dependency "client_manager/application_controller"

module ClientManager
  class SessionsController < ApplicationController

    def login
      redirect_to after_login_path if client_manager_current_user
    end

    def logout
      session.delete(:client_manager_current_user_id)
      redirect_to login_path
    end

    def login_attempt
      authorized_user = User.find_by(email: params[:email]).try(:authenticate, params[:password])

      if !authorized_user
        flash[:error] = "Invalid Username or Password"
        redirect_to login_path
      else
        session[:client_manager_current_user_id] = authorized_user.id
        redirect_to after_login_path
      end

    end


    def after_login_path
      if client_manager_current_user.superadmin
        return users_path
      else
        return clients_path
      end
    end

  end
end
