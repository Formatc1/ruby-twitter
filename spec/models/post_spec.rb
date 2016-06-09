require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create!(email: Faker::Internet.safe_email,
                         password: Faker::Internet.password(7, 10),
                         username: Faker::Internet.user_name,
                         visible_name: Faker::Name.name)
    @post1 = Post.create!(content: Faker::Lorem.sentence,
                          user: @user)
    @post2 = Post.create!(content: Faker::Lorem.sentence,
                          user: @user,
                          reply_to: @post1)
  end
  after(:all) do
    @user.destroy
    @post1.destroy
  end

  it 'should create post with author' do
    expect(@post1.user).to eq(@user)
  end

  it 'user should have own posts' do
    expect(@user.posts).to include(@post1, @post2)
  end

  it 'should have comment' do
    expect(@post1.replies).to eq([@post2])
  end

  it 'should be reply to other post' do
    expect(@post2.reply_to).to eq(@post1)
  end

  it 'post should not have empty content' do
    expect do
      Post.create!(content: '',
                   user: @user)
    end.to raise_error(Mongoid::Errors::Validations)
  end
end
