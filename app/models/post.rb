class Post
  include Mongoid::Document
  field :content, type: String
  field :created_at, type: DateTime
  belongs_to :user
  has_and_belongs_to_many :tags

  before_create do |post|
    post.created_at = Time.now.utc
  end
end
