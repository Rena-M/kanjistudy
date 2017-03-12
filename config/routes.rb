Rails.application.routes.draw do
  root 'kanjis#index'
  resources :kanjis
  resources :letters, only: [:show]
end
