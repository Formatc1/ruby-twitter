class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    @posts = posts_visible_for_user
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
      else
        @posts = posts_visible_for_user
        format.html { render 'home/index', notice: 'Post was not created.' }
      end
    end
  end

  def like
    @post = Post.find(params[:id])
    current_user.like(@post)
    redirect_to :back
  end

  def unlike
    @post = Post.find(params[:id])
    current_user.unlike(@post)
    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def posts_visible_for_user
    Post.where(user: current_user.id)
        .union
        .in(user: current_user.following.collect(&:id))
        .order(created_at: :desc)
        .paginate(page: params[:page], per_page: 20)
  end
end
