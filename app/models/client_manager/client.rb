module ClientManager
  class Client < ApplicationRecord
    belongs_to :user
    before_validation :generate_token, unless: :token_exists?
    validates_presence_of :name, :token, :user_id
    validate :number_of_users_clients


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

    def number_of_users_clients
      if user.clients.count >= user.maximum_number_of_clients
        self.errors[:base] << "Maximum number of clients reached. You cannot create more than #{user.maximum_number_of_clients} clients."
      end
    end

  end
end
