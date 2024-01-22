require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post') }
  context 'index page' do
    it "show user's username" do
      visit user_posts_path(user)
      expect(page).to have_content(user.name)
    end

    it 'show user profile picture' do
      visit user_posts_path(user)
      expect(page).to have_selector("img[src='#{user.photo}']")
    end

    it 'shows the number of posts user has' do
      visit user_posts_path(user)
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
    it "shows a post's title" do
      visit user_posts_path(user)
      recent_post = user.recent_posts[0]
      expect(page).to have_content(recent_post.title) if recent_post
    end
  end
  context 'Click' do
    it "redirects me to that post's show page when I click on a post" do
      visit user_posts_path(user)
      if user.posts.any?
        first_recent_post = user.recent_posts[0]
        click_link first_recent_post.title
        expect(page).to have_current_path(user_post_path(user, first_recent_post))
      end
    end
  end
end