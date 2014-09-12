class DashboardsController < ApplicationController
  def show
    @rant = Rant.new
    @my_rants = kenny_loggins.rants
    @others_rants = Rant.where('user_id != ?', kenny_loggins.id)

  end
end