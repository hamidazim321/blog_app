class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.user = current_user
    if @like.save
      flash[:notice] = 'Liked post'
    else
      flash[:error] = @like.errors.full_messages.to_sentence
    end
    redirect_to request.referrer || root_url
  end
end
