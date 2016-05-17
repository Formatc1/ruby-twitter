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
end
