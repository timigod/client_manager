require_dependency "client_manager/application_controller"


module ClientManager
  class UsersController < ApplicationController
    before_action :set_user, only: [:destroy, :update, :edit]
    before_action :authenticate_superadmin, except: [:edit, :update]
    before_action :authenticate_editor, only: [:edit, :update]
    before_action :set_edit_view_variables, only: [:edit]
    layout "client_manager/none", only: [:new, :edit]

    def new
      @user = ClientManager::User.new
    end

    def index
      @users = ClientManager::User.where.not(id: client_manager_current_user.id, superadmin: true)
    end

    def edit
      session[:return_to] ||= request.referer
    end

    def update
      @user.assign_attributes(user_update_params)
      return if password_change_attempted? && !handle_password_update
      return if max_clients_is_too_low?
      if @user.save
        flash[:success] = "User successfully updated"
      else
        flash[:error] = @user.errors.empty? ? "Error" : @user.errors.full_messages.uniq.to_sentence
      end

      redirect_to session.delete(:return_to)
    end

    def create
      @user = ClientManager::User.new(user_params)
      if @user.save
        flash[:success] = "User successfully created"
      else
        flash[:error] = @user.errors.empty? ? "Error" : @user.errors.full_messages.uniq.to_sentence
      end
      redirect_to users_path
    end


    def destroy
      @user.destroy
      flash[:success] = "User successfully deleted"
      redirect_to users_path
    end


    private


    def authenticate_editor
      if !(client_manager_current_user == @user)
        authenticate_superadmin
      end
    end

    def set_edit_view_variables
      @modal_title = "MY PROFILE" if client_manager_current_user == @user
      @client_manager_current_user_is_superadmin = @user.superadmin && @user == client_manager_current_user

      if @client_manager_current_user_is_superadmin
        @max_clients = "Infinity"
        @input_type = "text"
      else
        @max_clients = @user.maximum_number_of_clients
        @input_type = "number"
      end

      if client_manager_current_user == @user
        @button_text = "Save Profile"
      else
        @button_text = "Save User"
      end
    end

    def max_clients_is_too_low?
      if !(params[:user][:maximum_number_of_clients].blank?) && (params[:user][:maximum_number_of_clients].to_i <= @user.clients.count)
        flash[:error] = "User already has #{@user.clients.count} clients. Max. number of clients cannot be lower."
        redirect_to session.delete(:return_to)
        return true
      end
      return false
    end

    def handle_password_update
      if @new_password != @new_password_confirmation
        flash[:error] = "Confirmation password mismatch. Password not changed. Nothing was updated."
        redirect_to session.delete(:return_to)
        return false
      else
        @user.assign_attributes(password: @new_password)
        flash[:success] = "Password changed successfully"
        return true
      end
    end

    def password_change_attempted?
      @new_password = params[:user][:new_password]; @new_password_confirmation = params[:user][:new_password_confirmation]
      return (!@new_password.blank? || !@new_password_confirmation.blank?) && client_manager_current_user == @user
    end

    def set_user
      @user = ClientManager::User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :maximum_number_of_clients)
    end

    def user_update_params
      params.require(:user).permit(:name, :maximum_number_of_clients)
    end
  end
end
