Rails.application.routes.draw do
  get 'users/new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root :to => "application#home"
  get  '/signup',  to: 'users#new'
end
