# Activity model
# Fields:
# - user (belogns_to)
# - post (belogns_to)
# - activity_type (integer ENUM)
class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  enum activity_type: [:create_post, :comment, :share, :like]
end
