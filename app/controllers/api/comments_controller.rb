class Api::CommentsController < Api::ApiController
  def index
    @post = Post.includes(:comments).find_by_id(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end
end
