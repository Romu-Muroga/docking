Rails.application.routes.draw do
  root to: 'tops#index'
  namespace :admin do
    resources :categories
    resources :tops, only: %i[index]
    resources :users, only: %i[index edit update destroy]
  end
  get '/categories/:category_id/users/:id', to: 'users#show', as: :category_user
  get '/categories/:category_id/posts', to: 'posts#index', as: :category_posts
  resources :likes, only: %i[create destroy]
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :posts do
    get :search, on: :collection
    get :autocomplete_post_eatery_name, on: :collection
    get :autocomplete_post_eatery_food, on: :collection
    get :autocomplete_post_eatery_address, on: :collection
    resources :comments, only: %i[create destroy]
  end
  get '/posts/hashtag/:name', to: 'posts#hashtag'
  resources :users do
    post :confirm, on: :collection
    get :destroy_confirm, on: :member
    get :iine_post_list, on: :member
    get :password_reset, on: :member
    patch :password_update, on: :member
  end
end
