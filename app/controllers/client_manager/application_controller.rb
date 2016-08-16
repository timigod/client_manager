module ClientManager
  class ApplicationController < ActionController::Base
    use_growlyflash
    protect_from_forgery with: :exception


  end
end
