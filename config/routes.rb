Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :sessions
  resources :translations
  
  get ':org/:repo', to: 'repos#show'

  root to: 'sessions#new'
end
