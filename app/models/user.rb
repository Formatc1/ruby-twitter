# User model
# Fields:
# - email (string)
# - username (string)
# - visible_name (string)
# - posts (has_many)
# - followers (has_many through followers)
# - following (has_many through followers)
# - activities (has_many)
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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

  has_many :posts, through: :activities, source: :post do
    def liked
      where('activities.activity_type = ?', Activity.activity_types[:like])
    end

    def created
      where('activities.activity_type = ?', Activity.activity_types[:create_post])
    end

    def commented
      where('activities.activity_type = ?', Activity.activity_types[:comment])
    end

    def shared
      where('activities.activity_type = ?', Activity.activity_types[:share])
    end
  end

  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true

  def follow(other_user)
    active_relationships.create(user_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(user_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end
end
