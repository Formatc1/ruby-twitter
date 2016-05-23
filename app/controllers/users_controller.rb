class UsersController < ApplicationController
  def show
    @posts = User.where(username: params[:username])
                 .first
                 .posts
                 .order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 20)
  end
end
