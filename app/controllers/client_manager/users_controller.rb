require_dependency "client_manager/application_controller"

module ClientManager
  class UsersController < ApplicationController

    def new
      @user = User.new
    end

    def index
      @users = User.all
    end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "User successfully created"
      else
        flash[:error] = "Error creating user"
      end
      render 'index'
    end


    private

    def user_params
      params.require(:user).permit(:name, :email, :maximum_number_of_client, :password, :password_confirmation)
    end
  end
end
