Rails.application.routes.draw do
  mount ClientManager::Engine => "/client_manager"
end
