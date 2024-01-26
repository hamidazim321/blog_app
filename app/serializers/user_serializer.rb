class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :photo, :email
end
