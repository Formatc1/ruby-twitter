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

    def filter(types)
      where('activities.activity_type IN (?)', types)
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

  def self.wall(user)
    # SELECT * FROM "activities"
    # INNER JOIN users ON activities.user_id = users.id
    # LEFT JOIN followers ON users.id = followers.user_id AND
    #   followers.follower_id = 2 OR followers.user_id = 2
    # LEFT OUTER JOIN activities AS tmp ON
    #   tmp.post_id = activities.post_id AND
    #   activities.created_at < tmp.created_at
    # WHERE (tmp.post_id IS NULL AND ((followers.follower_id = 2 AND
    #   activities.activity_type IN (3,0,2)) OR (activities.user_id = 2 AND
    #   activities.activity_type IN (0,2)) OR (followers.user_id = 2 AND
    #   activities.activity_type IN (1,3))))
    Activity.includes(:post)
            .includes(:user)
            .joins('INNER JOIN users ON activities.user_id = users.id')
            .joins('LEFT JOIN followers ON users.id = followers.user_id')
            .joins('LEFT OUTER JOIN activities AS tmp ON
                      tmp.post_id = activities.post_id AND
                      activities.created_at < tmp.created_at')
            .where('tmp.post_id IS NULL AND (
                    (followers.follower_id = ? AND
                      activities.activity_type IN (?)) OR
                    (activities.user_id = ? AND
                      activities.activity_type IN (?)) OR
                    (followers.user_id = ? AND
                      activities.activity_type IN (?)))',
                   user.id,
                   [Activity.activity_types[:like],
                    Activity.activity_types[:create_post],
                    Activity.activity_types[:share]],
                   user.id,
                   [Activity.activity_types[:create_post],
                    Activity.activity_types[:share]],
                   user.id,
                   [Activity.activity_types[:comment],
                    Activity.activity_types[:like]]
                  )
            .order(created_at: :desc)
  end
end
