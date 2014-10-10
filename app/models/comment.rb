class Comment < ActiveRecord::Base
  belongs_to :rant
  belongs_to :user
end