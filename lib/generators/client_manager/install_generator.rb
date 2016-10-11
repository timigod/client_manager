module ClientManager
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration


    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end


    def create_initializer_file
      copy_file 'client_manager.rb', 'config/initializers/client_manager.rb'
    end


    def include_controller_concerns
      fname = "app/controllers/application_controller.rb"
      line = "include ClientManager::Concerns::SetClientByToken"

      if File.exist?(File.join(destination_root, fname))
        if parse_file_for_line(fname, line)
          say_status("skipped", "Concern is already included in the application controller.")
        elsif is_rails_api?
          inject_into_file fname, after: "class ApplicationController < ActionController::API\n" do
            <<-'RUBY'
  include ClientManager::Concerns::SetClientByToken
            RUBY
          end
        else
          inject_into_file fname, after: "class ApplicationController < ActionController::Base\n" do
            <<-'RUBY'
  include ClientManager::Concerns::SetClientByToken
            RUBY
          end
        end
      else
        say_status("skipped", "app/controllers/application_controller.rb not found. Add 'include ClientManager::Concerns::SetClientByToken' to any controllers that require authentication.")
      end
    end

    def convert_api_only_to_normal
      if is_rails_api?
        add_action_dispatch_to_application
        require_sprockets_railtie
        remove_api_only_declaration
      end
    end

    private


    def add_action_dispatch_to_application
      application do
        "config.middleware.use ActionDispatch::Flash"
      end
      say_status("insert", "config/application.rb")
    end

    def require_sprockets_railtie
      fname = "config/application.rb"

      if File.exist?(File.join(destination_root, fname))
        gsub_file 'config/application.rb', '# require "sprockets/railtie"', 'require "sprockets/railtie"'
      else
        say_status("skipped", "application.rb not found, cannot add sprockets")
      end
    end

    def remove_api_only_declaration
      fname = "config/application.rb"

      if File.exist?(File.join(destination_root, fname))
        gsub_file 'config/application.rb', 'config.api_only = true', ''
      else
        say_status("skipped", "application.rb not found")
      end
    end


    def parse_file_for_line(filename, str)
      match = false

      File.open(File.join(destination_root, filename)) do |f|
        f.each_line do |line|
          if line =~ /(#{Regexp.escape(str)})/mi
            match = line
          end
        end
      end
      match
    end

    def is_rails_api?
      fname = "app/controllers/application_controller.rb"
      line = "class ApplicationController < ActionController::API"
      parse_file_for_line(fname, line)
    end

  end
end