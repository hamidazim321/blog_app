class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id, class_name: 'User'
  has_many :comments
  has_many :likes

  def update_post_counter
    user.update(posts_counter: user.posts.count)
  end

  def recent_comments (limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
