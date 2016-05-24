class Post
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Paperclip

  field :content, type: String
  belongs_to :user, inverse_of: :posts
  field :tags, type: Array
  has_and_belongs_to_many :liked_by, class_name: 'User',
                                     inverse_of: :liked_posts
  has_many :replies, class_name: 'Post', inverse_of: 'reply_to'
  belongs_to :reply_to, class_name: 'Post', inverse_of: 'replies'

  has_mongoid_attached_file :image, styles: {
    original: ['1920x1080>', :jpg],
    thumb: ['200x200#', :jpg]
  }
  validates_attachment_content_type :image, content_type: %r{image\/.*}
  validates :content, presence: true

  before_save do |post|
    tags = post.content.scan(/#(\w+)/).flatten
    post.tags = tags.to_set.to_a
  end
end
