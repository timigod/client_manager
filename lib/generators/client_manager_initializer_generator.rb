class ClientManagerInitializerGenerator < Rails::Generators::Base

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end


  def create_initializer_file
    copy_file 'client_manager.rb', 'config/initializers/client_manager.rb'
  end
end