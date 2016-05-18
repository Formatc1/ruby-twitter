Rails.application.routes.draw do
  post 'posts/create'

  get 'home/index'

  devise_for :users
  root to: 'home#index'
end
