ClientManager::Engine.routes.draw do
  root to: 'users#index'
  get 'login', to: 'sessions#login'
  get 'clients', to: 'clients#index'
  resources :users, only: [:index, :new, :create]
end
