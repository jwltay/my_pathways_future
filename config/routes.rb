Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :programmes, only: %i[show] do
    resources :pathways, only: %i[create]
  end
  resources :pathways, only: %i[index update destroy]
  resources :careers, only: %i[index show] do
    resources :programmes, only: %i[index]
  end
  resources :users, only: %i[edit update]
end
