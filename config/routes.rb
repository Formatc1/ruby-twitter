Rails.application.routes.draw do
  devise_for :users

  get 'home', to: 'home#index'
  get 'user/:username', to: 'users#show_posts', as: 'user'
  post 'posts/create'
  post 'posts/like/:id', to: 'posts#like', as: 'post_like'
  delete 'posts/unlike/:id', to: 'posts#unlike', as: 'post_unlike'

  root to: 'home#index'
end
