ClientManager::Engine.routes.draw do
  root to: 'sessions#login'
  get 'login', to: 'sessions#login'
  get 'test_flash', to: 'sessions#test_flash'
end
