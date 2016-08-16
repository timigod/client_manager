ClientManager::Engine.routes.draw do
  get 'login', to: 'sessions#login'
  get 'test_flash', to: 'session#test_flash'
end
