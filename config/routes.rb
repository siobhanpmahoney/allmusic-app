Rails.application.routes.draw do

  get 'sessions/new'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  get 'add_artist', to: 'artists#add_artist', as: 'add_artist'


  # root 'controller#action'

  resources :users
  # resources :artists
  resources :artists, only: [:new, :create, :show, :add_artist]
  resources :sessions

  root to: 'welcome#home'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
