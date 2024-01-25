class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :author_id
end
