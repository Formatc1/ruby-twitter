class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to '/', notice: 'Post was successfully created.' }
      else
        format.html { render '/', notice: 'Post was not created.' }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
