class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id, class_name: 'User'

  def update_post_counter
    user.update(posts_counter: user.posts.count)
  end
end
