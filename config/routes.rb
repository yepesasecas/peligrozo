Rails.application.routes.draw do
  get 'upcoming_movies_controller/show'

  root 'movies#index'

  get 'admins/index'
  get 'landing/index'

  resources :movies do
    resources :theaters
    get :get, on: :collection
  end

  resources :users do
    resources :favorite_genres
    resources :favorite_theaters do
      post :delete, on: :collection
    end
    resources :favorite_movies
  end

  resources :upcoming_movies, only: [:show]

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
end
