Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_account_access', on: :member
  end
  resources :beers
  resources :styles
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  root 'sessions#new'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'signout', to: 'sessions#destroy'
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]
  post 'places', to:'places#search'
  delete 'signout', to: 'sessions#destroy'
end
