require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:test_user) { User.create!(name: 'Hamid', photo: 'PhotoURL', bio: "I'm a professional testing user") }
  subject { Post.new(title: 'testing post', text: 'hello world', user: test_user) }

  before { subject.save }

  it 'is valid with a title' do
    expect(subject).to be_valid
  end

  it 'is invalid without a title' do
    subject.title = ''
    expect(subject).not_to be_valid
  end

  it 'is invalid if title exceeds 250 characters' do
    invalid_title = 'a' * 251
    subject.title = invalid_title
    expect(subject).not_to be_valid
  end

  it 'should associate the post with the correct author' do
    expect(subject.user.name).to eq('Hamid')
  end

  it 'is invalid if comments_counter is less than zero' do
    subject.comments_counter = -1
    expect(subject).not_to be_valid
  end

  it 'is valid when comments_counter is positive integer' do
    subject.comments_counter = 1
    expect(subject).to be_valid
  end

  it 'is invalid if likes_counter is less than zero' do
    subject.likes_counter = -1
    expect(subject).not_to be_valid
  end

  it 'is valid when likes_counter is positive integer' do
    subject.likes_counter = 1
    expect(subject).to be_valid
  end

  it 'updates comments_counter when a comment is added' do
    initial_comments_counter = 0
    expect(subject.comments_counter).to eq(initial_comments_counter)
    subject.save
    subject.comments.create(post: subject, user: test_user, text: 'Hi Tom!')
    expect(subject.reload.comments_counter).to eq(initial_comments_counter + 1)
  end
end
