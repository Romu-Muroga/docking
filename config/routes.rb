Rails.application.routes.draw do
  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :categories do
    resources :users, only: %i[show]
  end
  resources :posts
end
