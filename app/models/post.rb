# Post model
# Fields:
# - content (text)
# - tags (has_many through PostTag)
# - user (belongs_to)
# - replies (has_many)
# - reply_to (belongs_to)
# - image (has_one)
# - activities (belongs_to)
class Post < ActiveRecord::Base
  belongs_to :reply_to, class_name: 'Post', foreign_key: 'reply_to_id'
  has_many :replies, class_name: 'Post', foreign_key: 'reply_to_id'
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :post_tags
  has_many :tags, through: :post_tags
end
