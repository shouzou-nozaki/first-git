Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy' 
  
  get 'signup', to: 'users#new'
  resources :users, only:[:create,:show,:edit,:update] 
  resources :microposts
  
  resources :relationships, only: [:index,:create, :destroy]
  
  
end

