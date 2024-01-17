class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.get_all_posts
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end
end
