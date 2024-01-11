require 'rails_helper'

RSpec.describe User, type: :model do 
  subject {User.new(name: 'Hamid', photo: 'PhotoURL', bio: "I'm a professional testing user")}

  it 'is invalid if name is blank' do
    subject.name = ""
    expect(subject).not_to be_valid
  end

  it 'is invalid if post counter is not a positive integer' do
    subject.posts_counter = -1
    expect(subject).not_to be_valid
  end
end