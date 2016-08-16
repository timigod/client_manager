require_dependency "client_manager/application_controller"

module ClientManager
  class UsersController < ApplicationController

    def index
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
      end
    end




    private

    def user_params
      params.require(:user).permit(:name, :email, :maximum_number_of_client)
    end
  end
end
