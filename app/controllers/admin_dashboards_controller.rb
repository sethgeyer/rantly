class AdminDashboardsController < ApplicationController

  def show
    @keen_list = KeenMetric.find_logins_per_hour



    # puts "fudge"
  end

end