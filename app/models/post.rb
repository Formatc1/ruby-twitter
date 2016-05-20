class Post
  include Mongoid::Document
  field :content, type: String
  field :created_at, type: DateTime
  belongs_to :user, inverse_of: :posts
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :liked_by, class_name: 'User',
                                     inverse_of: :liked_posts

  before_create do |post|
    post.created_at = Time.now.utc
  end
end
