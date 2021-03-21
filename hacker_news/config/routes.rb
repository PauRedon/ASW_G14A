Rails.application.routes.draw do
  resources :news
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'news#index'
end
