Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'
  resources :user_sessions
  resources :contacts
  resources :projects
  
  resources :users, except: :index do
    member do
      get :activate
      get :following, :followers
    end
  end
  
  resources :posts
  resources :comments, except: [:new, :edit]

  #get "/feed", to: "application#feed"

  get '/login', to: 'user_sessions#new', :as => :login
  delete '/logout' => 'user_sessions#destroy', :as => :logout
  root "application#home"
  get "/discuss", to: "application#discuss"
  get  '/signup',  to: 'users#new'
  get "/search", to: "application#search"
 # get "/about", to: "application#about"
  resources :relationships,       only: [:create, :destroy]
  resources :likes,       only: [:create, :destroy]

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
end
