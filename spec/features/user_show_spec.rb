require 'rails_helper'

RSpec.feature 'User Show Page', type: :feature do
  before do
    @user = User.create(name: 'example_user', bio: 'This is a bio') # Adjust attributes based on your model
    @post1 = @user.posts.create(title: 'Post 1', text: 'Content for post 1') # Adjust for your actual attribute
    @post2 = @user.posts.create(title: 'Post 2', text: 'Content for post 2') # Adjust for your actual attribute
    @post3 = @user.posts.create(title: 'Post 3', text: 'Content for post 3') # Adjust for your actual attribute

    visit user_path(@user)
  end

  scenario 'Display user information' do
    save_and_open_page
    expect(page).to have_css('.user-card img.profile-picture')
    expect(page).to have_content(@user.name) # Change to name
    expect(page).to have_content("Number of posts: 3") # Assuming all posts are created
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
