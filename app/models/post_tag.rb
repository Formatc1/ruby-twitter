# PostTag model
# Fields
# - tag (belongs_to)
# - post (belogns_to)
# It is used as join table to many-to-many relation
class PostTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :post
end
