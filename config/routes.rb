Rails.application.routes.draw do
  resources :words
  resources :search, only: :index
  root 'search#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
