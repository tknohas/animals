Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users do
    get 'page/:page', action: :index, on: :collection
    member do
      get :favorites
    end
  end
  namespace :animals do
    resource :search, only: :show, controller: :search
  end
  namespace :tags do
    resource :search, only: :show, controller: :search
  end
  resources :animals do
    resource :favorites, only: [:create, :destroy]
    get 'page/:page', action: :index, on: :collection
  end
  resources :facilities
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
end
