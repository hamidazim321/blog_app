class Api::PostsController < Api::ApiController
  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    @post = Post.find_by_id(params[:id])
    render json: @post
  end
end