Rails.application.routes.draw do
  post 'posts/create'
  post 'posts/:post_id/like', to: 'activities#like', as: 'like'

  get 'home', to: 'home#index'

  devise_for :users
  root to: 'home#index'
end
