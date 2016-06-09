require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user1 = User.create!(email: Faker::Internet.safe_email,
                          password: Faker::Internet.password(7, 10),
                          username: Faker::Internet.user_name,
                          visible_name: Faker::Name.name)
    @user2 = User.create!(email: Faker::Internet.safe_email,
                          password: Faker::Internet.password(7, 10),
                          username: Faker::Internet.user_name,
                          visible_name: Faker::Name.name)

    @post1 = Post.create!(content: Faker::Lorem.paragraph,
                          user: @user1)
  end

  after(:all) do
    @user1.destroy
    @user2.destroy
    @post1.destroy
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

    expect(@user1.likes?(@post1)).to be true
    @user1.unlike(@post1)
  end

  it 'unlike post' do
    @user1.like(@post1)
    @user1.unlike(@post1)

    expect(@user1.likes?(@post1)).to be false
  end

  it 'should have strong password' do
    expect do
      User.create!(email: Faker::Internet.safe_email,
                   password: Faker::Internet.password(1, 5),
                   username: Faker::Internet.user_name,
                   visible_name: Faker::Name.name)
    end.to raise_error(Mongoid::Errors::Validations)
  end

  it 'should have correct email address' do
    expect do
      User.create!(email: 'wrong_email',
                   password: Faker::Internet.password(7, 10),
                   username: Faker::Internet.user_name,
                   visible_name: Faker::Name.name)
    end.to raise_error(Mongoid::Errors::Validations)
  end

  it 'user should have not empty username' do
    expect do
      User.create!(email: Faker::Internet.safe_email,
                   password: Faker::Internet.password(7, 10),
                   visible_name: Faker::Name.name)
    end.to raise_error(Mongoid::Errors::Validations)
  end

  it 'should not create second user with the same email' do
    expect do
      User.create!(email: @user1.email,
                   password: Faker::Internet.password(7, 10),
                   username: Faker::Internet.user_name,
                   visible_name: Faker::Name.name)
    end.to raise_error(Mongoid::Errors::Validations)
  end

  it 'should not create second user with the same username' do
    expect do
      User.create!(email: Faker::Internet.safe_email,
                   password: Faker::Internet.password(7, 10),
                   username: @user1.username,
                   visible_name: Faker::Name.name)
    end.to raise_error(Mongoid::Errors::Validations)
  end
end
