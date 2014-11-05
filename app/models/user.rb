class User < ActiveRecord::Base
  has_secure_password
  has_many :comments, as: :commentable

  has_many :commenter_relationships,
  foreign_key: :commenter_id,
  class_name: "Comment"


  has_many :rants

  has_many :followed_user_relationships,
  foreign_key: :follower_id,
  class_name: "InterestingRanter"
  has_many :followed_users, through: :followed_user_relationships

  has_many :follower_relationships,
  foreign_key: :followed_user_id,
  class_name: "InterestingRanter"
  has_many :followers, through: :follower_relationships


  has_many :favorites

  mount_uploader :avatar, AvatarUploader

  validates :first_name, :last_name, :username, :email, :bio, :rant_frequency, :image, presence: true
  validates :username, :uniqueness => true
  validates :password, length: {minimum: 8, message: "must be 8 characters in length", :allow_blank => true}

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end