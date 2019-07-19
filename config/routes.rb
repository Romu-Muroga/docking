Rails.application.routes.draw do
  root to: 'tops#index'
  resources :users do
    get :destroy_confirm, on: :member
    get :iine_post_list, on: :member
  end
  resources :sessions, only: %i[new create destroy]
  resources :categories do
    resources :users, only: %i[show]
    resources :posts, only: %i[index]
  end
  resources :posts do
    get :search, on: :collection
    get :autocomplete_post_eatery_name, on: :collection
    get :autocomplete_post_eatery_food, on: :collection
    get :autocomplete_post_eatery_address, on: :collection
    resources :comments, only: %i[create destroy]
  end
  get '/post/hashtag/:name', to: 'posts#hashtag'
  resources :likes, only: %i[create destroy]
end
