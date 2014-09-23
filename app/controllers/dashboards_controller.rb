class DashboardsController < ApplicationController
  def show
    @my_rants = kenny_loggins.rants
    @others_rants = Rant.where('user_id != ?', kenny_loggins.id)
    mention_name = "@#{kenny_loggins.username}"
    @mentioned_rants = (Rant.where("details ilike ?", "%#{mention_name}%") + Rant.where("topic ilike ?", "%#{mention_name}%")).uniq

  end

  def flexy
  render :flexy, layout:false
  end
end