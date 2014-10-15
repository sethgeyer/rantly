class InterestingRanter < ActiveRecord::Base


belongs_to :user


def self.find_followers_to_receive_email(rant)
  followers = InterestingRanter.where(person_id: rant.user_id).map { |interesting_ranter| interesting_ranter.user.email }
  if followers != []
    followers
  else
    nil
  end

end

end