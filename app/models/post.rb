# Post model
# Fields:
# - content (text)
# - tags (has_many through PostTag)
# - user (belongs_to)
# - replies (has_many)
# - reply_to (belongs_to)
# - image (has_attached_file managed by Paperclip)
# - activities (belongs_to)
class Post < ActiveRecord::Base
  belongs_to :reply_to, class_name: 'Post', foreign_key: 'reply_to_id'
  has_many :replies, class_name: 'Post', foreign_key: 'reply_to_id'
  has_many :activities, class_name: 'Activity', foreign_key: 'post_id'
  has_many :post_tags
  has_many :tags, through: :post_tags

  has_many :users, through: :activities, source: :user do
    def creator
      where('activities.activity_type = ?', Activity.activity_types[:create_post])[0]
    end

    def who_comment
      where('activities.activity_type = ?', Activity.activity_types[:comment])
    end

    def who_like
      where('activities.activity_type = ?', Activity.activity_types[:like])
    end

    def who_share
      where('activities.activity_type = ?', Activity.activity_types[:share])
    end
  end

  has_attached_file :image, styles: { medium: ['1920x1080>', :jpg], thumb: ['200x200#', :jpg] }
  # default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: %r{image\/.*}

  after_create do |post|
    Activity.create(user: User.current, post: post, activity_type: :create_post)
  end

  def author
    users.creator
  end
end
