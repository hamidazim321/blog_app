require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  before :each do
    @user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
    @post = Post.create(user: @user, title: 'Hello', text: 'This is my first post')
    @comment = Comment.create(text: 'test comment', user: @user, post: @post)
  end

  # rubocop:disable Metrics/BlockLength
  context 'index page' do
    it "show user's username" do
      visit user_posts_path(@user)
      expect(page).to have_content(@user.name)
    end

    it 'shows the first comments on a post' do
      comment1 = Comment.create(post: @post, user: @user, text: 'First comment on the post')
      visit user_posts_path(@user)
      expect(page).to have_content(comment1.text)
    end

    it 'shows the number of comments a post has' do
      Comment.create(post: @post, user: @user, text: 'First comment on the post')
      Comment.create(post: @post, user: @user, text: 'Second comment on the post')

      visit user_posts_path(@user)
      expect(page).to have_content("Comments: #{@post.comments.count}")
    end

    it 'shows the number of likes a post has' do
      Like.create(post: @post, user: @user)
      Like.create(post: @post, user: User.create(name: 'John'))

      visit user_posts_path(@user)
      expect(page).to have_content("Likes: #{@post.likes.count}")
    end

    it 'show user profile picture' do
      visit user_posts_path(@user)
      expect(page).to have_selector("img[src='#{@user.photo}']")
    end

    it 'shows the number of posts user has' do
      visit user_posts_path(@user)
      expect(page).to have_content("Number of posts: #{@user.posts_counter}")
    end
    it "shows a post's title" do
      visit user_posts_path(@user)
      recent_post = @user.posts[0]
      expect(page).to have_content(recent_post.title) if recent_post
    end

    it "shows some of the post's body." do
      visit user_posts_path(@user)
      recent_post = @user.posts[0]
      if recent_post
        if recent_post.text.length > 50
          expect(page).to have_content("#{recent_post.text[0, 49]}...")
        else
          expect(page).to have_content(recent_post.text)
        end
      end
    end

    it 'shows the first comment on the post' do
      visit user_posts_path(@user)
      recent_post = @user.posts[0]
      expect(page).to have_content(recent_post.comments[0].text)
    end

    it 'shows how many comments a post has' do
      visit user_posts_path(@user)
      recent_post = @user.posts[0]
      expect(page).to have_content("Comments: #{recent_post.comments.count}")
    end

    it 'shows how many likes a post has' do
      visit user_posts_path(@user)
      recent_post = @user.posts[0]
      expect(page).to have_content("Likes: #{recent_post.likes.count}")
    end

    it 'shows a section for pagination' do
      visit user_posts_path(@user)
      @user.posts[0]
      expect(page).to have_button('Pagination')
    end
  end
  # rubocop:enable Metrics/BlockLength
  context 'Click' do
    it "redirects me to that post's show page when I click on a post" do
      visit user_posts_path(@user)
      if @user.posts.any?
        recent_post = @user.posts[0]
        click_link recent_post.title
        expect(page).to have_current_path(user_post_path(@user, recent_post))
      end
    end
  end
end
