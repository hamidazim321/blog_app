class Post < ApplicationRecord
  belongs_to :user, foreign_key: :author_id, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  before_validation :set_comments_counter, :set_likes_counter
  after_save :update_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, :likes_counter, presence: true,
                                               numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  private

  def update_posts_counter
    user.update(posts_counter: user.posts.count)
  end

  def set_comments_counter
    self.comments_counter ||= 0
  end

  def set_likes_counter
    self.likes_counter ||= 0
  end

  public

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
