ClientManager::Engine.routes.draw do
  root to: 'users#index'
  get 'login', to: 'sessions#login'
  resources :users, only: [:index, :new, :create]
end
