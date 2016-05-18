# Tag model
# Fields
# - tag (string)
# - posts (has_many through PostTag)
class Tag < ActiveRecord::Base
  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :tag, uniqueness: true
end
