Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resources :ratings, only: [:index, :new, :create, :destroy]
  root 'breweries#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'signout', to: 'sessions#destroy'
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
  post 'places', to:'places#search'
  resources :styles, only: [:index, :show]
  delete 'signout', to: 'sessions#destroy'
end
