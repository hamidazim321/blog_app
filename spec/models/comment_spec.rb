require 'rails_helper'

RSpec.describe Post, type: :model do 
  let (:test_user) {User.new(name: 'Hamid', photo: 'PhotoURL', bio: "I'm a professional testing user")}
  let (:test_post) {Post.new(title: 'testing post', text: 'hello world', user: test_user)}
  subject {Comment.new(text: 'testing comment', user: test_user, post: test_post)}

  it 'should be valid only when all text, post and user are present' do
    expect(subject).to be_valid
  end

  it 'should be invalid if user if not present' do
    subject.user = nil
    expect(subject).not_to be_valid
  end

  it 'should be invalid if post if not present' do
    subject.post = nil
    expect(subject).not_to be_valid
  end

  it 'should be invalid if text if not present' do
    subject.text = nil
    expect(subject).not_to be_valid
  end
end