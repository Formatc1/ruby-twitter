Rails.application.routes.draw do
  devise_for :users

  get 'home', to: 'home#index'
  get 'user/:username', to: 'users#show_posts', as: 'user'
  post 'posts/create'

  root to: 'home#index'
end
