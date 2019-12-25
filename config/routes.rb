Rails.application.routes.draw do
  get 'user_zeros/create'
  resources :user_sessions
  resources :users do
    member do
      get :activate
    end
  end
  
  get '/login', to: 'user_sessions#new'
  post '/logout' => 'user_sessions#destroy', :as => :logout
  root :to => "application#home"
  get  '/signup',  to: 'users#new'
  resources :user_zeros, only: [:new, :create]
end
