class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :user_id, :post_id, :user_name

  def user_name
    object.user.name
  end
end
