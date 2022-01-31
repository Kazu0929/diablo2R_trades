Rails.application.routes.draw do
  root 'static_pages#home'
  get 'sessions/new'
  get 'signup', to: 'users#new'
  get 'search', to: 'trades#search'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :trades, only: [:create, :destroy]
  resources :chats, only: [:create, :show]
end
