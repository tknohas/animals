Rails.application.routes.draw do
  get 'tags/search'
  get 'genres/index'
  get 'genres/edit'
  devise_for :users
  root to: "home#index"
  resources :users
  namespace :animals do
    resource :search, only: :show, controller: :search
  end
  namespace :tags do
    resource :search, only: :show, controller: :search
  end
  resources :animals
  get 'get_genre/children', to: 'animals#get_category_children', defaults: { format: 'json' }
  get 'get_genre/grandchildren', to: 'animals#get_category_grandchildren', defaults: { format: 'json' }
  resources :genres, except: [:new, :show]
  post 'animals/:id' => 'animals#show'
end
