# Main page controller
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @activities = User.wall(current_user).paginate(page: params[:page],
                                                   per_page: 20)
  end
end
