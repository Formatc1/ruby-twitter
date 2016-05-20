class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :username,     type: String
  field :visible_name, type: String

  has_and_belongs_to_many :following, class_name: 'User',
                                      inverse_of: :followers,
                                      autosave: true
  has_and_belongs_to_many :followers, class_name: 'User', inverse_of: :following

  has_many :posts
  has_and_belongs_to_many :liked_posts, class_name: 'Post',
                                        inverse_of: :liked_by

  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true
  validates :visible_name, presence: true

  def follow(user)
    following << user if id != user.id && !following.include?(user)
  end

  def unfollow(user)
    following.delete(user)
  end

  def following?(user)
    following.include?(user)
  end
end
