module ClientManager
  class Engine < ::Rails::Engine
    require 'growlyflash'
    require 'font-awesome-rails'

    isolate_namespace ClientManager
  end
end
