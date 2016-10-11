ClientManager.setup do |config|
  config.token_secret = nil # PLEASE SET SECRET AND USE ENVIRONMENT VARIABLES FOR PRODUCTION
  config.middleware.use ActionDispatch::Flash
end