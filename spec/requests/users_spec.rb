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
  end
end
