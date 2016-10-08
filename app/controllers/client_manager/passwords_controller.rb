require_dependency "client_manager/application_controller"

module ClientManager
  class PasswordsController < ApplicationController

    def change

    end

    def change_password_attempt
      if params[:new_password] == params[:confirm_new_password]
        current_user.update(password: params[:new_password], password_changed: true)
        flash[:notice] = "Successfully changed password"
        redirect_to login_path
      else
        flash[:error] = "Passwords do not match"
        render 'change'
      end
    end


    def password_change_params
      params.permit(:new_password, :confirm_new_password)
    end
  end
end
