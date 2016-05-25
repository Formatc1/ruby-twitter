class UsersController < ApplicationController
  before_action :find_user
  before_action :authenticate_user!, :except => [:show]

  def show
    @posts = @user.posts
                  .paginate(page: params[:page], per_page: 20)
  end

  def follow
    current_user.follow(@user)
    redirect_to :back
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_to :back
  end

  private

  def find_user
    @user = User.find_by(username: params[:username])
  end
end
