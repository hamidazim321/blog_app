require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { User.create(name: 'Agneta', id: 1) }

  describe 'Get /index' do
    before { get users_url }

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'The response status is 200' do
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      expect(response).to render_template('users/index')
    end

    it 'template includes the correct body' do
      expect(response.body).to include('<h1> List of users goes here </h1>')
    end
  end

  describe 'Get /show' do
    before { get user_url(user) }

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'The response status is 200' do
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      expect(response).to render_template('users/show')
    end

    it 'template includes the correct body' do
      expect(response.body).to include('<h1>Searched user goes here</h1>')
    end
  end
end
