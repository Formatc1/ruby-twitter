class TagsController < ApplicationController
  def show
    @posts = Post.where(:tags.in => [params[:tag]])
                 .paginate(page: params[:page], per_page: 20)
  end
end
