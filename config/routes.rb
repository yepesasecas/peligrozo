Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'upcoming_movies_controller/show'

  root 'movies#index'

  get 'admins/index'
  get 'landing/index'

  resources :movies do
    resources :theaters
    get :get, on: :collection
  end

  resources :users do
    get :history, on: :member
    resources :favorite_genres
    resources :favorite_movies
    resources :eliminated_movies
    resources :favorite_theaters do
      post :delete, on: :collection
    end
  end

  resources :upcoming_movies, only: [:show]

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
end
