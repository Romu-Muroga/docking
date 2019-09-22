Rails.application.routes.draw do
  controller :tops do
    root action: :index
    namespace :admin do
      resources :tops, only: %i[index]
    end
  end
  controller :categories do
    namespace :admin do
      resources :categories, except: %i[show]
    end
  end
  controller :comments do
    resources :comments, only: %i[create destroy]
  end
  controller :likes do
    resources :likes, only: %i[create destroy]
  end
  controller :sessions do
    get '/login', action: :new
    post '/login', action: :create
    delete '/logout', action: :destroy
  end
  controller :posts do
    get '/posts/hashtag/:name', action: :hashtag
    get 'posts/categories/:category_id', action: :index, as: :category_posts
    resources :posts do
      collection do
        get :autocomplete_post_eatery_name
        get :autocomplete_post_eatery_food
        get :autocomplete_post_eatery_address
        get :search
      end
    end
  end
  controller :users do
    get 'users/:id/categories/:category_id', action: :show, as: :user_category_posts
    namespace :admin do
      resources :users, only: %i[index edit update destroy]
    end
    resources :users, except: %i[index] do
      post :confirm, on: :new
      member do
        get :destroy_confirm
        get :iine_post_list
        get :password_reset
        patch :password_update
      end
    end
  end
end
