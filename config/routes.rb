Rails.application.routes.draw do
  # root 'controller#action'
  resources :users
  # resources :artists
  get "/artists/search", to: "artists#search", as: :search
  post "/artists", to: "artists#search_results", as: :search_results
  resources :artists, only: [:search, :search_results, :index, :show]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
