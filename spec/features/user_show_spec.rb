require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  before do
    @user = User.create(name: 'example_user', bio: 'This is a bio', photo: 'https://unsplash.com/photos/F_-0BxGuVvo')
    @post1 = @user.posts.create(title: 'Post 1', text: 'Content for post 1') 
    @post2 = @user.posts.create(title: 'Post 2', text: 'Content for post 2') 
    @post3 = @user.posts.create(title: 'Post 3', text: 'Content for post 3') 

    visit user_path(@user)
  end

  scenario 'Display user information' do
    expect(page).to have_selector("img[src='#{@user.photo}']")
    expect(page).to have_content(@user.name) 
    expect(page).to have_content('Number of posts: 3') 
    expect(page).to have_content(@user.bio)
  end

  scenario 'Display user\'s first 3 posts' do
    expect(page).to have_content(@post1.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post3.title)
  end

  scenario 'View all user\'s posts' do
    click_link('See all posts')
    expect(current_path).to eq(user_posts_path(@user))
  end

  scenario 'Redirect to post show page when clicking a post' do
    click_link(@post1.title)
    expect(current_path).to eq(user_post_path(@user, @post1))
  end
end
