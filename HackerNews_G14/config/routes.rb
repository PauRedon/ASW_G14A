Rails.application.routes.draw do
  resources :users do
    member do
      post 'login'
    end
  end
  
  
 # scope 'news' do
#    resources :contribucios, as: 'news'
#  end
  resources :contribucios do
    member do
      put 'like'
    end
    collection do
      get 'news'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'contribucios#index'
end
