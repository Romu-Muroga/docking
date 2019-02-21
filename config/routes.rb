Rails.application.routes.draw do
  root to: "sessions#new"
  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :categories do
    resources :users, only: %i[show]
    resources :posts, only: %i[index]
  end
  resources :posts do
    get :search, on: :collection
  end
  resources :likes, only: %i[create destroy]
end
