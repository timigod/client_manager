module ClientManager
  class ApplicationController < ActionController::Base
    use_growlyflash
    protect_from_forgery with: :exception

    def client_manager_current_user
      @client_manager_current_user ||= session[:client_manager_current_user_id] && User.find_by_id(session[:client_manager_current_user_id])
    end


    def authenticate_user
      if !client_manager_current_user
        flash[:error] = "Unauthorized"
        redirect_to login_path
      elsif !client_manager_current_user.password_changed
        flash[:error] = "You must change your password before proceeding"
        redirect_to change_password_path
      end
    end

    def authenticate_superadmin
      authenticate_user
      if !client_manager_current_user.superadmin
        flash[:error] = "Unauthorized"
        redirect_to login_path
      end
    end

    helper_method :client_manager_current_user
  end
end
