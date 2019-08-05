Rails.application.routes.draw do
  root to: 'tops#index'
  resources :users do
    get :destroy_confirm, on: :member
    get :iine_post_list, on: :member
  end
  resources :sessions, only: %i[new create destroy]
  namespace :admin do
    resources :categories
    resources :tops, only: %i[index]
    resources :users, only: %i[index edit update destroy]
  end
  get '/categories/:category_id/users/:id', to: 'users#show', as: :category_user
  get '/categories/:category_id/posts', to: 'posts#index', as: :category_posts
  resources :posts do
    get :search, on: :collection
    get :autocomplete_post_eatery_name, on: :collection
    get :autocomplete_post_eatery_food, on: :collection
    get :autocomplete_post_eatery_address, on: :collection
    resources :comments, only: %i[create destroy]
  end
  get '/posts/hashtag/:name', to: 'posts#hashtag'
  resources :likes, only: %i[create destroy]
end
