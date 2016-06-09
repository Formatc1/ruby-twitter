require 'rails_helper'

RSpec.describe User, type: :model do
  it 'follow other user' do
    user1 = User.create!(email: 'user1@example.com',
                         password: 'testtest',
                         username: 'user1',
                         visible_name: 'user1')
    user2 = User.create!(email: 'user2@example.com',
                         password: 'testtest',
                         username: 'user2',
                         visible_name: 'user2')
    user1.follow(user2)

    expect(user1.following).to eq([user2])
  end
end
