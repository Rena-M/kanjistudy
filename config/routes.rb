Rails.application.routes.draw do
  devise_for :users
  root 'kanjis#index'
  resources :kanjis
  resources :letters, only: [:show]
  get   'users/:id'   =>  'users#show'
  delete  'kanjis/:id'  => 'kanjis#destroy'
end
