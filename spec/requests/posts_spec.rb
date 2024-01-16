require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let (:user) {User.create(name: 'Hamid', id: 1)}
  let (:user_url) {user_url(user)}

  def create_post(author)
    Post.create(
      title: 'Test post',
      text: 'This is for controller testing',
      user: author
    )
  end

  describe 'Get /index' do
    before do
      user_post = create_post(user)
      get user_posts_path(user)
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'The response status is 200' do
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      expect(response).to render_template("posts/index")
    end

    it 'template includes the correct body' do
      expect(response.body).to include('<h1>Specific user posts goes here</h1>')
    end
  end

  describe 'Get /show' do
    before do
      user_post = create_post(user)
      get user_post_path(user, user_post)
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'The response status is 200' do
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      expect(response).to render_template("posts/show")
    end

    it 'template includes the correct body' do
      expect(response.body).to include('<h1>Specific post of a user goes here</h1>')
    end
  end
end