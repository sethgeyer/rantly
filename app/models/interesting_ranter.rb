class InterestingRanter < ActiveRecord::Base

  def self.build_follow_or_unfollow_link(current_user, rant)
    interesting_rant = InterestingRanter.where(user_id: current_user.id, person_id: rant.user_id).first
    if interesting_rant
      "<a href='/user/interesting_ranters/#{interesting_rant.id}' data-method='DELETE' rel='nofollow'>Unfollow</a>"
    else
      "<a href='/user/interesting_ranters?interesting_ranter_id=#{rant.user_id}' data-method='POST' rel='nofollow'>Follow</a>"
    end
  end



end