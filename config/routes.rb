RottenMangoes::Application.routes.draw do

  get 'reviews/new'

  get 'reviews/create'

  get 'sessions/new'

  get 'sessions/create'

  # resources :movies

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  resources :movies do
    resources :reviews, only: [:new, :create]
  end


  root to: 'movies#index'
end

