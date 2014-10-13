class Dashboard


  def find_by_current_user(user)
    user.rants
  end

  def find_all_but_current_user(user)
    Rant.where(shown: true).where('user_id != ?', user.id)

  end

  def find_mentions(user)
    mention_name = "@#{user.username}"
    @mentioned_rants = (Rant.where("details ilike ?", "%#{mention_name}%").where(shown: true) + Rant.where("topic ilike ?", "%#{mention_name}%").where(shown: true)).uniq
  end
end