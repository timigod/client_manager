module ClientManager
  class ClientsController < ApplicationController
    before_action :authenticate_user
    before_action :set_client, only: [:edit, :show, :update, :destroy]

    def index
      @clients = Client.where(user_id: current_user.id)
    end

    def new
      @client = current_user.clients.new
    end

    def show

    end

    def create
      @client = current_user.clients.new(client_params)
      if @client.save
        flash[:success] = "Client successfully created"
      else
        flash[:error] = @client.errors.empty? ? "Error" : @client.errors.full_messages.uniq.to_sentence
      end
      redirect_to clients_path
    end

    def destroy
      @client.destroy
      redirect_to clients_path
    end


    private


    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name)
    end
  end
end