Rails.application.routes.draw do
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
    resources :favorite_movies do
      post :delete, on: :collection
    end
  end

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  
end
