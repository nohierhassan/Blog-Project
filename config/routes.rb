Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :articles
get "signup", to: 'users#new'
resources :users, except: [:new]
get "login", to: 'sessions#new'             # handling the login form
post "login", to: 'sessions#create'         # handling the login action itself
delete "logout", to: 'sessions#destroy'     # handling the logout action
end
