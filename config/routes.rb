RottenMangoes::Application.routes.draw do

  get 'search', to: 'movies#search'

  namespace :admin do
    resources :users
  end

  # get 'reviews/new'

  # get 'reviews/create'

  # get 'sessions/new'

  # get 'sessions/create'

  resources :movies

  resources :users, only: [:new, :create]

  # resources :sessions, only: [:new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  root to: 'movies#index'
end

