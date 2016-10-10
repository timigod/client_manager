module ClientManager::Concerns::SetClientByToken
  extend ActiveSupport::Concern

  included do
    before_action :set_client
  end


  def set_client
    puts request.headers["HTTP_CLIENT_ID"]
  end

end