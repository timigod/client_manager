module ClientManager
  class Engine < ::Rails::Engine
    require 'jquery-rails'
    require 'growlyflash'
    require 'font-awesome-rails'
    require 'email_validator'
    require 'bcrypt'

    isolate_namespace ClientManager
  end
end
