class PostsController < ApplicationController
  def create
    User.current = current_user

    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { render 'posts/create', notice: 'Post was successfully created.' }
      else
        format.html { render 'posts/create', notice: 'Post was not created.' }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
