class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def like
    post = Post.find(params[:post_id])
    if current_user.like(post)
      redirect_to '/'
    end
  end
end
