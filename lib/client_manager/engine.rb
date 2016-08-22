module ClientManager
  class Engine < ::Rails::Engine
    require 'jquery-rails'
    require 'growlyflash'
    require 'font-awesome-rails'
    require 'email_validator'

    isolate_namespace ClientManager
  end
end
