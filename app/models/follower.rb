# Follower model
# Fields
# - user (belongs_to)
# - follower (belogns_to)
# It is used as join table to many-to-many relation
class Follower < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
end
