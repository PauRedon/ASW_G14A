Rails.application.routes.draw do
  resources :comments do
    member do
      post 'reply_comment'
    end
  end
  resources :users do
    collection do
      post 'login'
    end
  end
  
  
  resources :contribucios do
    member do
      put 'like'
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
  end
  match '/news' => 'contribucios#news', :via => :get, :as => 'news'
  match '/asks' => 'contribucios#asks', :via => :get, :as => 'asks'
  get '/contribucios/users', to: 'contribucios#users'
  
  resources :sessions, :only => [:new, :create, :destroy]
  match '/logout', to: 'sessions#destroy', via: [:get, :post]
  
  get '/auth/:provider/callback' => 'sessions#omniauth'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'contribucios#index'
end
