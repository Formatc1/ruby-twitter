# Main page controller
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    # @posts = current_user.posts.filter(
    #   [
    #     Activity.activity_types[:create_post],
    #     Activity.activity_types[:share]
    #   ]
    # ).paginate(page: params[:page], per_page: 20)

    @activities = User.wall(current_user).paginate(page: params[:page], per_page: 20)
    # @following_ids = current_user.following.collect(&:id).push(current_user.id)
  end
end
