ClientManager::Engine.routes.draw do
  root to: 'sessions#login'
  get 'login', to: 'sessions#login'
  get 'logout', to: 'sessions#logout'
  post 'login_attempt', to: 'sessions#login_attempt'
  get 'change_password', to: 'passwords#change'
  post 'change_password_attempt', to: 'passwords#change_password_attempt'
  resources :clients
  resources :users
end
