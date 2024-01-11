require 'rails_helper'

RSpec.describe Post, type: :model do 
  let (:user) {User.create(name: 'Hamid', photo: 'PhotoURL', bio: "I'm a professional testing user")}
  subject {Post.create(title: 'testing post', text: 'hello world', user: user)}

  it 'is valid with a title' do
    expect(subject).to be_valid
  end

  it 'is invalid without a title' do
    subject.title = ""
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
end