class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.includes(:posts, :comments).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = User.includes(:posts, :comments).find(params[:user_id])
    @post = @user.posts.find_by(id: params[:id])
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
      flash[:error] = @post.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])
    @user = User.find_by_id(params[:user_id])
    if @post
      @post.destroy
      @post.user.decrement!(:posts_counter)
      flash[:notice] = 'Post deleted successfully'
      redirect_to user_posts_path(@user)
    else
      flash[:error] = @post.errors.full_messages.to_sentence
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
