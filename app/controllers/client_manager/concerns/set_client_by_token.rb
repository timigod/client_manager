module ClientManager::Concerns::SetClientByToken
  extend ActiveSupport::Concern

  included do
    before_action :set_client
    if respond_to?(:helper_method)
      helper_method :current_client
    end
  end


  def unauthorized
    head 401
  end

  private

  def set_client
    client_token = request.headers["HTTP_CLIENT_TOKEN"] || params["client-token"]
    if !(client_token.blank?)
      begin
        decoded = JWT.decode client_token, ClientManager.token_secret, true, {:algorithm => 'HS256'}
      rescue JWT::DecodeError
        return unauthorized
      end
      if ClientManager::Client.exists?(decoded[0]["client_id"])
        @current_client = ClientManager::Client.find(decoded[0]["client_id"])
      else
        return unauthorized
      end
    else
      return unauthorized
    end
  end


  def current_client
    @current_client
  end

end