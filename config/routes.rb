Rails.application.routes.draw do
  get 'facilities/index'
  get 'facilities/new'
  get 'facilities/show'
  get 'facilities/edit'
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
  resources :animals do
    resource :favorites, only: [:create, :destroy]
  end
  resources :facilities
end
