class UsersController < ApplicationController
  def show
    @posts = User.find_by(username: params[:username])
                 .posts
                 .paginate(page: params[:page], per_page: 20)
  end
end
