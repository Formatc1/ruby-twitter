require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create!(email: 'user1@example.com',
                         password: 'testtest',
                         username: 'user1',
                         visible_name: 'user1')
    @post1 = Post.create!(content: Faker::Lorem.sentence,
                          user: @user1)
  end
  after(:all) do
    @user.destroy
    @post1.destroy
  end


end
