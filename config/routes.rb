Rails.application.routes.draw do
  root 'kanji#index'
  resources :kanjis
end
