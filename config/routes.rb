Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users
  namespace :animals do
    resource :search, only: :show, controller: :search
  end
  resources :animals
end
