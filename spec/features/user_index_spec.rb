require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'User Integration', type: :feature do
  let!(:user1) { User.create(name: 'John', posts_counter: 2) }
  let!(:user2) { User.create(name: 'Alice', posts_counter: 5) }

  describe 'User index page' do
    before { visit users_path }

    it 'displays the username of all other users' do
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user2.name)
    end

    it 'displays the profile picture for each user' do
      puts page.html
      expect(page).to have_css('img.profile-picture', count: User.count)
    end


    it 'displays the number of posts each user has written' do
      expect(page).to have_content("Number of posts: #{user1.posts_counter}")
      expect(page).to have_content("Number of posts: #{user2.posts_counter}")
    end

    it 'redirects to the user show page when clicking on a user' do
      click_link user1.name
      expect(page).to have_current_path(user_path(user1))
    end
  end
end
