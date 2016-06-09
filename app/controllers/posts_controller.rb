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

  def destroy
    @post = Post.find(params[:id])
    @post.destroy if @post == current_user
    redirect_to :back
  end

  def comment
    parent_post = Post.find(params[:id])
    @post = Post.new(post_params)
    @post.reply_to = parent_post
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Comment was successfully created.' }
      else
        @posts = posts_visible_for_user
        format.html { render 'home/index', notice: 'Comment was not created.' }
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

  def search
    query = params[:query]
    case query[0]
    when '#'
      return redirect_to tag_path(query[1..-1])
    when '@'
      return redirect_to user_path(query[1..-1])
    else
      return @posts = Post.for_js("this.content.match(/#{params[:query]}/)")
                          .paginate(page: params[:page], per_page: 10)
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def posts_visible_for_user
    Post.where(user: current_user.id)
        .union
        .in(user: current_user.following.collect(&:id))
        .paginate(page: params[:page], per_page: 10)
  end
end
