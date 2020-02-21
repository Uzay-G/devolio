Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  get 'user_zeros/create'
  resources :user_sessions
  resources :contacts
  resources :projects
  
  resources :users do
    member do
      get :activate
      get :following, :followers
    end
  end
  
  resources :posts do
    resources :comments, except: [:new, :edit]
  end

  get '/login', to: 'user_sessions#new', :as => :login
  delete '/logout' => 'user_sessions#destroy', :as => :logout
  root "application#home"
  get "/discuss", to: "application#discuss"
  get  '/signup',  to: 'users#new'
  resources :user_zeros, only: [:new, :create]
  resources :relationships,       only: [:create, :destroy]
  resources :likes,       only: [:create, :destroy]

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
