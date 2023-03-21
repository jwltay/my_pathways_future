Rails.application.routes.draw do
  devise_for :users
  root to: "users#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :subjects, only: %i[index show]
  resources :soft_skills, only: %i[index show]
  resources :programmes, only: %i[index show new create edit update]
end
