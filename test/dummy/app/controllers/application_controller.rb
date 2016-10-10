class ApplicationController < ActionController::Base
  include ClientManager::Concerns::SetClientByToken
  protect_from_forgery with: :exception


end
