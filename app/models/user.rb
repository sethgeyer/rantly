class User < ActiveRecord::Base
  has_secure_password
  has_many :rants
  has_many :interesting_ranters
  has_many :favorites

  validates :first_name, :last_name, :username, :email, :bio, :rant_frequency, :image, presence: true
  validates :username, :uniqueness => true
  validates :password, length: {minimum: 8, message: "must be 8 characters in length", :allow_blank => true}

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end