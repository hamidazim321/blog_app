class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.all_posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to user_posts_path
    else
      flash[:error] = 'There was an error creating the post.'
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
