Rails.application.routes.draw do
  devise_for :users
  get 'home', to: 'home#index'
  post 'posts/create'

  root to: 'home#index'
end
