Rails.application.routes.draw do
  root to: "sessions#new"
  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :categories do
    resources :users, only: %i[show]
    resources :posts, only: [:index]
  end
  resources :posts
end
