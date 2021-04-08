Rails.application.routes.draw do
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
  end
  match '/news' => 'contribucios#news', :via => :get, :as => 'news'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'contribucios#index'
end
