Rails.application.routes.draw do
  devise_for :users

  get 'home', to: 'posts#index'
  get 'user/:username', to: 'users#show', as: 'user'
  get 'tag/:tag', to: 'tags#show', as: 'tag'
  post 'posts/create'
  post 'posts/create/:id', to: 'posts#comment', as: 'post_comment'
  post 'posts/like/:id', to: 'posts#like', as: 'post_like'
  delete 'posts/unlike/:id', to: 'posts#unlike', as: 'post_unlike'

  root to: 'posts#index'
end
