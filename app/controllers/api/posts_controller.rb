class Api::PostsController < Api::ApiController
  def index
    @user = User.includes(:posts).find_by_id(params[:user_id])
    @posts = @user.posts
    render json: @posts
  end

  def show
    @post = Post.find_by_id(params[:id])
    render json: @post
  end
end
