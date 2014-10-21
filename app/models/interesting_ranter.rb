class InterestingRanter < ActiveRecord::Base


belongs_to :follower, class_name: "User"
belongs_to :followed_user, class_name: "User"


def self.find_followers_to_receive_email(rant)
  followers = InterestingRanter.where(followed_user_id: rant.user_id).map { |interesting_ranter| interesting_ranter.follower.email }
  if followers != []
    followers
  else
    nil
  end

end

end