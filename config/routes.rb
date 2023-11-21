Rails.application.routes.draw do
  # devise_for :users
    root 'pages#home'
    resources :recipes
    resources :users, except: [:new]
    get '/signup', to: 'users#new'
end
