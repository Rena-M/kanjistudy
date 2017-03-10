Rails.application.routes.draw do
  root 'kanjis#index'
  resources :kanjis
end
