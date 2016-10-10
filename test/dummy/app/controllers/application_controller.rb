class ApplicationController < ActionController::Base
  include ClientManager::Concerns::AuthenticateRequest
  protect_from_forgery with: :exception
end
