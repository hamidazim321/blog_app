require 'rails_helper'
RSpec.describe Post, type: :model do 
  let (:test_user) {User.new(name: 'Hamid', photo: 'PhotoURL', bio: "I'm a professional testing user")}
  let (:test_post) {Post.new(title: 'testing post', text: 'hello world', user: test_user)}
  subject {Like.new(user: test_user, post: test_post)}

  it 'is valid only when both user and post are present' do
    expect(subject).to be_valid
  end

  it 'is invalid if user is not present' do
    subject.user = nil
    expect(subject).not_to be_valid
  end

  it 'is invalid if post is not present' do
    subject.post = nil
    expect(subject).not_to be_valid
  end
end