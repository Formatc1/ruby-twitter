class UsersController < ApplicationController
  def show_posts
    @posts = User.where(username: params[:username])
                 .first
                 .posts
                 .paginate(page: params[:page], per_page: 20)
  end
end
