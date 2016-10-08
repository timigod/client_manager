module ClientManager
  class Client < ApplicationRecord
    belongs_to :user
    before_validation :generate_token, unless: :token_exists?
    validates_presence_of :name, :token, :user_id


    def token_exists?
      !self.token.blank?
    end


    private

    def generate_token
      if ClientManager.token_secret.blank?
        raise "config.token_secret is missing. Please set it in the client_manager.rb initializer."
      end
      payload = {client_id: self.id}
      token = JWT.encode payload, ClientManager.token_secret, 'HS256'
      self.update(token: token)
    end


  end
end
