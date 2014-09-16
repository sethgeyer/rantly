class User < ActiveRecord::Base
  has_secure_password
  has_many :rants
  has_many :interesting_ranters

  validates :first_name, :last_name, :username, :bio, :rant_frequency, presence: true
  validates :username, :uniqueness => true
  validates :password, length: {minimum: 8, message: "must be 8 characters in length"}
end