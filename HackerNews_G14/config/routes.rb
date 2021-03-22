Rails.application.routes.draw do
  resources :contribucios do
    member do
      put 'like'
    end
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'contribucios#index'
end
