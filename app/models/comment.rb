class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :text, presence: true

  after_save :update_comments_counter

  private

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
