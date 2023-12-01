Rails.application.routes.draw do
  # devise_for :users
    root 'pages#home'
    resources :recipes
    resources :users, except: [:new]
    get '/signup', to: 'users#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    resources :ingredients, except: [:destroy]
end
