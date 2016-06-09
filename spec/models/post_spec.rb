require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create!(email: Faker::Internet.safe_email,
                         password: Faker::Internet.password(7, 10),
                         username: Faker::Internet.user_name,
                         visible_name: Faker::Name.name)
    @post1 = Post.create!(content: Faker::Lorem.sentence,
                          user: @user)
  end
  after(:all) do
    @user.destroy
    @post1.destroy
  end

  it 'should create post with author' do
    expect(@post1.user).to eq(@user)
  end

  it 'user should have own post' do
    expect(@user.posts).to eq([@post1])
  end
end
