Rails.application.routes.draw do
  get '/items/me', to: 'items#me'
  resources :items do
    resources :books
    resources :reviews
  end
  devise_for :users
  resources :users do
    resources :reviews
  end
  root to: 'items#index'
end
