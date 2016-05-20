class Post
  include Mongoid::Document
  include Mongoid::Paperclip

  field :content, type: String
  field :created_at, type: DateTime
  belongs_to :user, inverse_of: :posts
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :liked_by, class_name: 'User',
                                     inverse_of: :liked_posts

  has_mongoid_attached_file :image, styles: {
    original: ['1920x1080>', :jpg],
    thumb: ['200x200#', :jpg]
  }
  validates_attachment_content_type :image, content_type: %r{image\/.*}
  validates :content, presence: true

  before_create do |post|
    post.created_at = Time.now.utc
  end
end
