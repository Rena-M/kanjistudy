Rails.application.routes.draw do
  devise_for :users
  root 'kanjis#index'
  resources :kanjis
  resources :letters, only: [:show]
end
