$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "client_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "client_manager"
  s.version     = ClientManager::VERSION
  s.authors     = ["Timi Ajiboye"]
  s.email       = ["timi@helloworld.ng"]
  s.homepage    = "https://github.com/timigod/client_manager"
  s.summary     = "Simple gem/engine to manage clients and their tokens for your Rails 5 API."
  s.description = "This gem provides views to add users (probably front-end or mobile developers) to your Rails 5 so they can create clients and manage tokens. With this, you can authenticate all requests and eventually track usage by each client."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0"
  s.add_dependency "growlyflash"
  s.add_dependency "sass-rails"
  s.add_dependency "font-awesome-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "bcrypt"
  s.add_dependency "jwt"

  s.add_development_dependency "sqlite3"
end
