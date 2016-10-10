module ClientManager
  class Engine < ::Rails::Engine
    require 'jquery-rails'
    require 'growlyflash'
    require 'font-awesome-rails'
    require 'bcrypt'
    require 'jwt'

    isolate_namespace ClientManager


    initializer "client_manager", before: :load_config_initializers do |app|
      Rails.application.routes.append do
        mount ClientManager::Engine, at: "/client_manager"
      end

      config.paths["db/migrate"].expanded.each do |expanded_path|
        Rails.application.config.paths["db/migrate"] << expanded_path
      end
    end
  end

  class << self
    mattr_accessor :token_secret
    self.token_secret = nil
  end

  def self.setup(&block)
    yield self
  end

end
