# User model
# Fields:
# - posts (has_many)
# - followers (has_many through followers)
# - following (has_many through followers)
# - activities (has_many)
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :activities, class_name: 'Activity', foreign_key: 'user_id'
  has_many :active_relationships, class_name: 'Follower',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Follower',
                                   foreign_key: 'user_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships,
                       source: :user
  has_many :followers, through: :passive_relationships,
                       source: :follower

  def follow(other_user)
    active_relationships.create(user_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(user_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
