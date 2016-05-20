class Tag
  include Mongoid::Document
  field :tag, type: String
  has_and_belongs_to_many :posts

  validates :tag, uniqueness: true, presence: true
end
