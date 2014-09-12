class User < ActiveRecord::Base
  has_secure_password
  has_many :rants
  has_many :interesting_ranters
end