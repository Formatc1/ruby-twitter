# Main page controller
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @posts = Post.where(author: Post.where('author_id IN (?) OR author_id = ?',
                                           current_user.following.collect(&:id),
                                           current_user.id))
  end
end
