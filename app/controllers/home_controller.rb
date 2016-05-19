# Main page controller
class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    # current_user.following.collect(&:activities)
    # Activity.where('user_id IN (?)', user2.followers.collect(&:id))

    # @posts = Post.where(author: Post.where('author_id IN (?) OR author_id = ?',
    #                                        current_user.following.collect(&:id),
    #                                        current_user.id))
    #              .paginate(page: params[:page], per_page: 20)
    # @posts = Activity.where('user_id IN (?)',
    #                         current_user.followers.collect(&:id))
    #                  .collect(&:post)
    @posts = Post.all.paginate(page: params[:page], per_page: 20)
  end
end
