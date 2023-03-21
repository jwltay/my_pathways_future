Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :programmes, only: %i[index show]
  resources :pathways, only: %i[index create update]
  resources :careers, only: %i[index show]
end
