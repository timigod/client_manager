require_dependency "client_manager/application_controller"

module ClientManager
  class SessionsController < ApplicationController

    def login
      flash[:notice] = "You signed up successfully"
    end

  end
end
