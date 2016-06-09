require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user1 = User.create!(email: 'user1@example.com',
                          password: 'testtest',
                          username: 'user1',
                          visible_name: 'user1')
    @user2 = User.create!(email: 'user2@example.com',
                          password: 'testtest',
                          username: 'user2',
                          visible_name: 'user2')

    @post1 = Post.create!(content: 'ghs',
                          user: @user1)
  end

  after(:all) do
    @user1.destroy
    @user2.destroy
  end

  it 'follow other user' do
    @user1.follow(@user2)

    expect(@user1.following).to eq([@user2])
    expect(@user2.followers).to eq([@user1])
    @user1.unfollow(@user2)
  end

  it 'unfollow other user' do
    @user1.follow(@user2)
    @user1.unfollow(@user2)

    expect(@user1.following).to eq([])
    expect(@user2.followers).to eq([])
  end

  it 'like post' do
    @user1.like(@post1)

    expect(@user1.likes?(@post1)).to eq(true)
    @user1.unlike(@post1)
  end

  it 'unlike post' do
    @user1.like(@post1)
    @user1.unlike(@post1)

    expect(@user1.likes?(@post1)).to eq(false)
  end
end
