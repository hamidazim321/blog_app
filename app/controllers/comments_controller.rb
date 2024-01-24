class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.user = current_user
    @comment.post = @post
    if @comment.save
      flash[:notice] = 'Comment posted successfully'
      redirect_to user_post_path(@post.user, @post)
    else
      flash[:error] = @comment.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def destroy
    @post = Post.find_by_id(params[:post_id])
    @comment = @post.comments.find_by_id(params[:id])

    if @comment
      @comment.destroy
      @post.decrement!(:comments_counter)
      flash[:notice] = 'Comment deleted successfully'
    else
      flash[:error] = 'Comment not found'
    end

    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
