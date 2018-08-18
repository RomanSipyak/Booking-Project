Rails.application.routes.draw do
  get '/items/me', to: 'items#me'
  resources :items do
    resources :books
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'items#index'
end
