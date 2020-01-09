Rails.application.routes.draw do
  get 'user_zeros/create'
  resources :user_sessions
  resources :contacts

  resources :users do
    member do
      get :activate
      get :following, :followers
    end
  end
  
  get '/login', to: 'user_sessions#new', :as => :login
  post '/logout' => 'user_sessions#destroy', :as => :logout
  root :to => "application#home"
  get "/discuss", to: "application#discuss"
  get  '/signup',  to: 'users#new'
  resources :user_zeros, only: [:new, :create]
  resources :relationships,       only: [:create, :destroy]
end
