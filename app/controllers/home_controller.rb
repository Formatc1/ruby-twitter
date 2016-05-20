# Main page controller
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @posts = Post.where(user: current_user.id)
                 .union
                 .in(user: current_user.following.collect(&:id))
                 .order(created_at: :desc)
  end
end
