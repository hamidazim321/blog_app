class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :name, uniqueness: true

  before_validation :initialize_posts_counter

  private

  def initialize_posts_counter
    self.posts_counter ||= 0
  end

  public

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  def all_posts
    posts.order(created_at: :desc)
  end
end
