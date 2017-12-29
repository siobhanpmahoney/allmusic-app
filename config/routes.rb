Rails.application.routes.draw do

  get 'sessions/new'
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'


  # root 'controller#action'

  resources :users
  # resources :artists
  resources :artists, only: [:new, :create, :show]
  resources :sessions

  root to: 'welcome#home'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
