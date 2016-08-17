module ClientManager
  class Engine < ::Rails::Engine
    require 'jquery-rails'
    require 'growlyflash'
    require 'font-awesome-rails'

    isolate_namespace ClientManager
  end
end
