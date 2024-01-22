require 'rails_helper'

RSpec.describe 'Post', type: :feature do

  before :each do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(user: @user, title: 'Hello', text: 'This is my first post')
    @comment = Comment.create(text: 'test comment', user: @user, post: @post)
  end
  context 'show page' do
    it "shows the post's title" do
      recent_post = @user.posts[0]
      visit user_post_path(@user, recent_post)
      expect(page).to have_content(recent_post.title)
    end
    it "shows the post's author" do
      recent_post = @user.posts[0]
      visit user_post_path(@user, recent_post)
      expect(page).to have_content(recent_post.user.name)
    end
    it 'shows how many likes the post has.' do
      recent_post = @user.posts[0]
      visit user_post_path(@user, recent_post)
      expect(page).to have_content("Likes: #{recent_post.likes_counter}")
    end
    it 'shows how many comments the post has.' do
      recent_post = @user.posts[0]
      visit user_post_path(@user, recent_post)
      expect(page).to have_content("Comments: #{recent_post.comments_counter}")
    end
  end

  it 'shows how the post body.' do
    recent_post = @user.posts[0]
    visit user_post_path(@user, recent_post)
    expect(page).to have_content(recent_post.text)
  end
  it 'shows how the username of each commentor' do
    recent_post = @user.posts[0]
    visit user_post_path(@user, recent_post)
    recent_post.comments.each do |comment|
      expect(page).to have_content(comment.user.name)
    end
  end
  it 'shows the comment each commentor left.' do
    recent_post = @user.posts[0]
    visit user_post_path(@user, recent_post)
    recent_post.comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end
end
