Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :musics

  get 'musics/artist_params'

  root 'musics#index'
end
