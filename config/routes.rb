Rails.application.routes.draw do
  resources :vote_comments
  resources :votes
  resources :comments do
    member do
      post 'reply_comment'
    end
    collection do
      get 'users'
    end
    member do
      put 'like', to: 'comments#like'
      put 'dislike', to: 'comments#unlike'
    end
    collection do
      get 'commented'
    end
  end
  resources :users do
    collection do
      post 'login'
    end
  end

  resources :contribucios do
    member do
      put 'like', to: 'contribucios#like'
      put 'dislike', to: 'contribucios#unlike'
    end
   collection do
       get 'news'
    end
    collection do
       get 'asks'
    end
    collection do
      get 'users'
    end
    member do
      post 'comentar'
    end
    collection do
      get 'liked'
    end
  end
  match '/news' => 'contribucios#news', :via => :get, :as => 'news'
  match '/asks' => 'contribucios#asks', :via => :get, :as => 'asks'
  get '/contribucios/users', to: 'contribucios#users'
  get '/contribucios/liked/:id', to: 'contribucios#liked'
  get '/comments/commented/:id', to: 'comments#commented'
  
  resources :sessions, :only => [:new, :create, :destroy]
  match '/logout', to: 'sessions#destroy', via: [:get, :post]
  
  get '/auth/:provider/callback' => 'sessions#omniauth'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'contribucios#index'
end
