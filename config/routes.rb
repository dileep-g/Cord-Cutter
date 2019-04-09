Rails.application.routes.draw do

  root 'pages#home'

  resources :devices
  resources :set_top_boxes
  resources :packages
  resources :channels
  resources :users

  get '/home', to: 'pages#home'

  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  get '/antenna/:id', to: 'antennas#show', as: 'antenna'
  post '/antenna/:id', to: 'antennas#update_antenna', as: 'update_antenna'

  get '/own_boxes/:id', to: 'own_boxes#show', as: 'own_box'
  post '/own_boxes/:id', to: 'own_boxes#update_own_set_top_box', as: 'update_own_box'

  get '/own_device/:id', to: 'own_devices#show', as: 'own_device'
  post '/own_device/:id', to: 'own_devices#update_own_device', as: 'update_own_device'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
